import sys
import re
import sympy as sp
from sympy.parsing.sympy_parser import (
    parse_expr,
    standard_transformations,
    implicit_multiplication_application,
    convert_xor,
)
from PyQt6.QtWidgets import (
    QApplication, QMainWindow, QWidget, QVBoxLayout, QHBoxLayout,
    QPushButton, QTextEdit, QLabel, QFrame, QScrollArea, QDialog,
    QSpinBox, QDialogButtonBox, QMessageBox, QTabWidget, QTextBrowser
)
from PyQt6.QtCore import Qt

# ================= 常量定义 消除魔法数字 =================
MAX_UNI_DEGREE = 5
WINDOW_MIN_W = 780
WINDOW_MIN_H = 640
FRACTION_SPIN_MIN = -999999
FRACTION_SPIN_MAX = 999999
EVALF_DIGITS = 10

TRANSFORMATIONS = standard_transformations + (
    implicit_multiplication_application,
    convert_xor,
)

# ------------------ 分数控件【内部强制自动约分】 ------------------
class FractionWidget(QWidget):
    """分数线形式显示分数，构造内部自动约分，负号外置"""
    def __init__(self, numerator, denominator, parent=None):
        super().__init__(parent)
        rat = sp.Rational(numerator, denominator)
        self.negative = (rat.p < 0)
        self.num = str(abs(rat.p))
        self.den = str(abs(rat.q))
        self._setup_ui()

    def _setup_ui(self):
        outer_layout = QHBoxLayout()
        outer_layout.setAlignment(Qt.AlignmentFlag.AlignCenter)
        outer_layout.setSpacing(4)
        outer_layout.setContentsMargins(0, 0, 0, 0)
        if self.negative:
            neg_label = QLabel("−")
            neg_label.setAlignment(Qt.AlignmentFlag.AlignVCenter)
            neg_label.setStyleSheet("font-size:14pt;")
            outer_layout.addWidget(neg_label)
        frac_inner = QVBoxLayout()
        frac_inner.setSpacing(2)
        frac_inner.setContentsMargins(0, 0, 0, 0)
        num_label = QLabel(self.num)
        num_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        num_label.setStyleSheet("font-size:12pt;")
        line = QFrame()
        line.setFrameShape(QFrame.Shape.HLine)
        line.setFrameShadow(QFrame.Shadow.Sunken)
        line.setFixedHeight(2)
        den_label = QLabel(self.den)
        den_label.setAlignment(Qt.AlignmentFlag.AlignCenter)
        den_label.setStyleSheet("font-size:12pt;")
        frac_inner.addWidget(num_label)
        frac_inner.addWidget(line)
        frac_inner.addWidget(den_label)
        outer_layout.addLayout(frac_inner)
        self.setLayout(outer_layout)

# ------------------ 插入分数对话框【移除self.preview_widget实例成员，使用局部变量】 ------------------
class FractionDialog(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("插入分数")
        self.setMinimumWidth(320)
        self.num_spin = QSpinBox()
        self.num_spin.setRange(FRACTION_SPIN_MIN, FRACTION_SPIN_MAX)
        self.num_spin.setValue(1)
        self.den_spin = QSpinBox()
        self.den_spin.setRange(FRACTION_SPIN_MIN, FRACTION_SPIN_MAX)
        self.den_spin.setValue(1)

        self.preview_container = QWidget()
        self.preview_layout = QVBoxLayout(self.preview_container)
        self.preview_layout.setContentsMargins(10, 10, 10, 10)

        form_layout = QVBoxLayout()
        form_layout.addWidget(QLabel("分子:"))
        form_layout.addWidget(self.num_spin)
        form_layout.addWidget(QLabel("分母:"))
        form_layout.addWidget(self.den_spin)
        form_layout.addWidget(QLabel("预览："))
        form_layout.addWidget(self.preview_container)

        button_box = QDialogButtonBox(
            QDialogButtonBox.StandardButton.Ok | QDialogButtonBox.StandardButton.Cancel
        )
        button_box.accepted.connect(self.accept)
        button_box.rejected.connect(self.reject)

        layout = QVBoxLayout()
        layout.addLayout(form_layout)
        layout.addWidget(button_box)
        self.setLayout(layout)

        self.num_spin.valueChanged.connect(self._update_preview)
        self.den_spin.valueChanged.connect(self._update_preview)
        self._update_preview()

    def _clear_preview_items(self):
        while self.preview_layout.count() > 0:
            item = self.preview_layout.takeAt(0)
            w = item.widget()
            if w:
                w.setParent(None)
                w.deleteLater()

    def _update_preview(self):
        self._clear_preview_items()
        n = self.num_spin.value()
        d = self.den_spin.value()
        if d == 0:
            err = QLabel("分母不能为零")
            err.setStyleSheet("color: red; font-weight:bold; font-size:12pt;")
            self.preview_layout.addWidget(err)
        else:
            fw = FractionWidget(n, d)
            self.preview_layout.addWidget(fw)

    def get_fraction(self):
        return self.num_spin.value(), self.den_spin.value()

# ------------------ 帮助中心对话框 ------------------
class HelpDialog(QDialog):
    def __init__(self, parent=None):
        super().__init__(parent)
        self.setWindowTitle("帮助中心 · 疑难解答")
        self.setMinimumSize(620, 480)
        tab = QTabWidget()
        tab_general = QTextBrowser()
        tab_general.setOpenExternalLinks(False)
        help_general = """
<h3>📖 使用说明</h3>
<p><b>⚠️每一条方程必须包含英文等号 =，例如 x+y=0，不能只写 x+y</b></p>
<p>1.方程可以每行写一条，也可以同一行用英文逗号分隔多条。</p>
<p>2.幂次使用 ^ 符号，例 x^2 代表 x²</p>
<p>3.点击【插入分数】生成分数表达式，内部会自动约分</p>
<p>示例同一行方程组： 1+2=x, y+x=8 </p>
<br>
<b>支持范围：</b>
<ul>
<li>一元1‑5次多项式方程</li>
<li>二元一次、二元二次方程组</li>
<li>三元一次方程组</li>
</ul>
"""
        tab_general.setHtml(help_general)

        tab_faq = QTextBrowser()
        faq_text = """
<h3>❓常见问题 & 疑难解答</h3>

<p><b>Q1：提示表达式解析失败？</b><br>
A：检查是否使用中文符号；<b>每条方程必须写英文等号 =</b>，只写 x+y 这种代数式不是方程。等号左右两侧不能为空。</p>

<p><b>Q2：显示“无解或无穷多解”？</b><br>
A：方程组互相矛盾则无解；方程线性相关存在自由变量，则有无穷多组解。</p>

<p><b>Q3：什么是 CRootOf？</b><br>
A：部分三次、四次方程没有简单根式解，CRootOf代表多项式根的符号对象，可查看精确形式。</p>

<p><b>Q4：根号/分数显示异常？</b><br>
A：分数自动化为最简；根号内单个变量/数字不会额外加括号；复杂复合表达式才带括号。不要手写√符号，输入sqrt(x)。</p>

<p><b>Q5：“不是多项式”报错？</b><br>
A：本工具只支持多项式方程，不支持 sin、log 等超越函数。</p>

<p><b>Q6：解出现i代表什么？</b><br>
A：i是虚数单位，代表复数解，实数范围内该方程无实数解。</p>

<p><b>Q7：一元高于5次为什么不能解？</b><br>
A：数学上五次以上通用多项式没有根式求根公式。</p>
"""
        tab_faq.setHtml(faq_text)

        tab.addTab(tab_general, "使用说明")
        tab.addTab(tab_faq, "疑难解答")
        btns = QDialogButtonBox(QDialogButtonBox.StandardButton.Close)
        btns.rejected.connect(self.reject)
        lay = QVBoxLayout()
        lay.addWidget(tab)
        lay.addWidget(btns)
        self.setLayout(lay)

# ------------------ 根号辅助判断 ------------------
def _need_paren_inside_sqrt(expr):
    if expr.is_Number or expr.is_Symbol:
        return False
    return True

# ------------------ 递归渲染【增加try‑except兜底，修复sup HTML】 ------------------
def _render_expr(expr, layout):
    try:
        if expr.is_Integer:
            lbl = QLabel(str(expr))
            lbl.setStyleSheet("font-size:12pt;")
            layout.addWidget(lbl)
        elif expr.is_Rational:
            layout.addWidget(FractionWidget(expr.p, expr.q))
        elif expr.is_Symbol:
            lbl = QLabel(expr.name)
            lbl.setStyleSheet("font-size:12pt;")
            layout.addWidget(lbl)
        elif expr == sp.I:
            layout.addWidget(QLabel("i"))
        elif expr.is_Add:
            terms = expr.as_ordered_terms()
            first = True
            for term in terms:
                if first:
                    if (term.is_Mul and term.args[0].is_Number and term.args[0] < 0) or (term.is_Number and term < 0):
                        layout.addWidget(QLabel("−"))
                        _render_expr(-term, layout)
                    else:
                        _render_expr(term, layout)
                    first = False
                else:
                    if (term.is_Mul and term.args[0].is_Number and term.args[0] < 0) or (term.is_Number and term < 0):
                        layout.addWidget(QLabel(" − "))
                        _render_expr(-term, layout)
                    else:
                        layout.addWidget(QLabel(" + "))
                        _render_expr(term, layout)
        elif expr.is_Mul:
            coeff, rest = expr.as_coeff_Mul()
            if coeff != 1 or rest == 1:
                _render_expr(coeff, layout)
                if rest != 1:
                    _render_expr(rest, layout)
            else:
                for factor in expr.args:
                    _render_expr(factor, layout)
        elif expr.is_Pow:
            base, exp = expr.args
            if exp == sp.Rational(1, 2):
                sqrt_widget = QWidget()
                sqrt_layout = QHBoxLayout()
                sqrt_layout.setContentsMargins(0,0,0,0)
                sqrt_layout.setSpacing(2)
                sqrt_layout.addWidget(QLabel("√"))
                if _need_paren_inside_sqrt(base):
                    wrap = QWidget()
                    wrap_lay = QHBoxLayout(wrap)
                    wrap_lay.setContentsMargins(2,2,2,2)
                    wrap_lay.addWidget(QLabel("("))
                    _render_expr(base, wrap_lay)
                    wrap_lay.addWidget(QLabel(")"))
                    sqrt_layout.addWidget(wrap)
                else:
                    _render_expr(base, sqrt_layout)
                sqrt_widget.setLayout(sqrt_layout)
                layout.addWidget(sqrt_widget)
            else:
                base_widget = QWidget()
                base_lay = QHBoxLayout(base_widget)
                base_lay.setContentsMargins(0,0,0,0)
                _render_expr(base, base_lay)
                sup_label = QLabel(f"<sup>{sp.pretty(exp)}</sup>")
                sup_label.setTextFormat(Qt.TextFormat.RichText)
                base_lay.addWidget(sup_label)
                layout.addWidget(base_widget)
        elif expr.func == sp.sqrt:
            arg = expr.args[0]
            sqrt_widget = QWidget()
            sqrt_layout = QHBoxLayout()
            sqrt_layout.setContentsMargins(0,0,0,0)
            sqrt_layout.setSpacing(2)
            sqrt_layout.addWidget(QLabel("√"))
            if _need_paren_inside_sqrt(arg):
                wrap = QWidget()
                wrap_lay = QHBoxLayout(wrap)
                wrap_lay.setContentsMargins(2,2,2,2)
                wrap_lay.addWidget(QLabel("("))
                _render_expr(arg, wrap_lay)
                wrap_lay.addWidget(QLabel(")"))
                sqrt_layout.addWidget(wrap)
            else:
                _render_expr(arg, sqrt_layout)
            sqrt_widget.setLayout(sqrt_layout)
            layout.addWidget(sqrt_widget)
        else:
            s = sp.pretty(expr, use_unicode=True)
            lbl = QLabel(s)
            lbl.setStyleSheet("font-size:12pt;")
            layout.addWidget(lbl)
    except Exception:
        lbl_err = QLabel(sp.pretty(expr, use_unicode=True))
        lbl_err.setStyleSheet("color:#888888; font-size:11pt;")
        layout.addWidget(lbl_err)


def create_expression_widget(expr):
    widget = QWidget()
    layout = QHBoxLayout()
    layout.setContentsMargins(4,4,4,4)
    layout.setSpacing(4)
    _render_expr(expr, layout)
    layout.addStretch()
    widget.setLayout(layout)
    return widget

# ------------------ 主求解窗口 ------------------
class EquationSolver(QMainWindow):
    def __init__(self):
        super().__init__()
        self.setWindowTitle("方程求解器")
        self.setMinimumSize(WINDOW_MIN_W, WINDOW_MIN_H)
        central = QWidget()
        self.setCentralWidget(central)
        main_layout = QVBoxLayout(central)

        top_bar = QHBoxLayout()
        help_label = QLabel(
            "⚠️每条方程必须带英文等号 =。每行一个，或同一行用英文逗号分隔方程组。使用 ^ 表示幂（如 x^2）。\n"
            f"支持：一元 ≤{MAX_UNI_DEGREE} 次方程、二元一次/二次方程组、三元一次方程组。"
        )
        help_label.setWordWrap(True)
        self.btn_help = QPushButton("帮助中心")
        self.btn_help.clicked.connect(self.open_help)
        top_bar.addWidget(help_label)
        top_bar.addWidget(self.btn_help)
        main_layout.addLayout(top_bar)

        self.equation_edit = QTextEdit()
        self.equation_edit.setPlaceholderText(
            "示例1（每行一条）：\n1+2=x\ny+x=8\n\n示例2（同一行逗号隔开）：\n1+2=x, y+x=8\n\n其他例子：\nx^2 - 4 = 0\nx^2 + y^2 = 25, x+y=7\n三元：x+y+z=6, 2x-y+z=3, x+2y-z=2\n\n⚠️注意：必须写等号，等号左右不能为空，不要只写 x+y"
        )
        main_layout.addWidget(self.equation_edit)

        btn_layout = QHBoxLayout()
        insert_btn = QPushButton("插入分数")
        insert_btn.clicked.connect(self._insert_fraction)
        solve_btn = QPushButton("求解")
        solve_btn.clicked.connect(self._solve)
        btn_layout.addWidget(insert_btn)
        btn_layout.addStretch()
        btn_layout.addWidget(solve_btn)
        main_layout.addLayout(btn_layout)

        scroll = QScrollArea()
        scroll.setWidgetResizable(True)
        self.result_container = QWidget()
        self.result_layout = QVBoxLayout(self.result_container)
        self.result_layout.setAlignment(Qt.AlignmentFlag.AlignTop)
        scroll.setWidget(self.result_container)
        main_layout.addWidget(scroll, stretch=1)

    def open_help(self):
        dlg = HelpDialog(self)
        dlg.exec()

    def _insert_fraction(self):
        dlg = FractionDialog(self)
        if dlg.exec() == QDialog.DialogCode.Accepted:
            num, den = dlg.get_fraction()
            if den == 0:
                QMessageBox.warning(self, "错误", "分母不能为0。")
                return
            r = sp.Rational(num, den)
            self.equation_edit.insertPlainText(f"({r.p}/{r.q})")

    def _safe_parse(self, text):
        stripped = text.strip()
        if not stripped:
            raise ValueError("输入内容为空")
        only_name_pattern = re.fullmatch(r'[a-zA-Z_]+', stripped)
        if only_name_pattern is not None:
            raise ValueError(f"「{stripped}」不是合法数学表达式，仅输入变量名不能作为方程。")
        try:
            return parse_expr(stripped, transformations=TRANSFORMATIONS)
        except Exception:
            raise ValueError(f"无法解析「{stripped}」，请检查符号，全部使用英文符号。")

    def _clear_result_layout(self):
        while self.result_layout.count() > 0:
            item = self.result_layout.takeAt(0)
            w = item.widget()
            if w:
                w.setParent(None)
                w.deleteLater()

    def _has_free_sym_in_sol_tuple(self, sol_tuple):
        for elem in sol_tuple:
            if len(elem.free_symbols) > 0:
                return True
        return False

    def _solve(self):
        self.result_container.setUpdatesEnabled(False)
        try:
            self._clear_result_layout()
            raw_text = self.equation_edit.toPlainText().strip()
            if not raw_text:
                self._show_error("请输入方程内容。")
                return

            unified = raw_text.replace("\n", ",")
            raw_parts = re.split(r',', unified)
            parts = [p.strip() for p in raw_parts if p.strip()]

            eqs = []
            for part in parts:
                if "=" not in part:
                    raise ValueError(f"「{part}」不是完整方程。每一条方程必须包含英文等号 =，例如 x+y=0")
                lhs_str, rhs_str = part.split("=", 1)
                lhs_str = lhs_str.strip()
                rhs_str = rhs_str.strip()
                if len(lhs_str) == 0:
                    raise ValueError(f"方程片段「{part}」等号左侧不能为空")
                if len(rhs_str) == 0:
                    raise ValueError(f"方程片段「{part}」等号右侧不能为空")
                lhs = self._safe_parse(lhs_str)
                rhs = self._safe_parse(rhs_str)
                eqs.append(sp.Eq(lhs, rhs))

            try:
                eqs = [sp.Eq(sp.nsimplify(eq.lhs), sp.nsimplify(eq.rhs)) for eq in eqs]
            except Exception:
                raise ValueError("化简方程出错，请检查方程是否为合法多项式。")

            symbols_set = set()
            for eq in eqs:
                symbols_set.update(eq.free_symbols)
            symbols_list = sorted(symbols_set, key=str)
            n_vars = len(symbols_list)

            if n_vars == 1:
                if len(eqs) != 1:
                    self._show_error("一元方程只需要提供一个方程。")
                    return
                var = symbols_list[0]
                expr = eqs[0].lhs - eqs[0].rhs
                try:
                    poly = sp.Poly(expr, var)
                except sp.PolynomialError:
                    self._show_error("表达式不是多项式，当前仅支持多项式方程。")
                    return
                degree = poly.degree()
                if degree == 0:
                    self._show_error("这是常数方程，没有未知数，无法求解。")
                    return
                if degree > MAX_UNI_DEGREE:
                    self._show_error(f"当前仅支持次数 ≤{MAX_UNI_DEGREE} 的一元多项式方程。")
                    return
            # 求解+去重
                raw_sols = sp.solve(expr, var)
                seen = set()
                solutions = []
                for s in raw_sols:
                    simp_s = sp.simplify(s)
                    key = sp.pretty(simp_s)
                    if key not in seen:
                        seen.add(key)
                        solutions.append(simp_s)
                if not solutions:
                    self._show_result_label("无解")
                else:
                    titles = {
                        1: "一元一次方程", 2: "一元二次方程",
                        3: "一元三次方程", 4: "一元四次方程", 5: "一元五次方程"
                    }
                    self._show_result_label(f"{titles[degree]}的解：")
                    for idx, sol in enumerate(solutions):
                        row = QWidget()
                        row_layout = QHBoxLayout(row)
                        row_layout.setContentsMargins(2, 4, 2, 4)
                        lbl = QLabel(f"解 {idx+1}:")
                        lbl.setStyleSheet("font-weight: bold; font-size:11pt;")
                        row_layout.addWidget(lbl)
                        row_layout.addWidget(create_expression_widget(sol))
                        row_layout.addStretch()
                        self.result_layout.addWidget(row)

            elif n_vars == 2:
                if len(eqs) != 2:
                    self._show_error(f"二元方程组需要恰好两个方程，当前读到 {len(eqs)} 个。")
                    return
                x, y = symbols_list[0], symbols_list[1]
                max_deg = 0
                for eq in eqs:
                    try:
                        p = sp.Poly(eq.lhs - eq.rhs, x, y)
                        deg = p.total_degree()
                        if deg > max_deg:
                            max_deg = deg
                    except sp.PolynomialError:
                        self._show_error("检测到非多项式表达式，仅支持多项式方程组。")
                        return
                if max_deg > 2:
                    self._show_error("二元方程组最高只支持到二次。")
                    return
                if max_deg == 1:
                    try:
                        sol_set = sp.linsolve([eq.lhs - eq.rhs for eq in eqs], (x, y))
                    except Exception:
                        self._show_error("线性方程组求解失败，请检查方程。")
                        return
                    sol_list = list(sol_set)
                    if not sol_list:
                        self._show_result_label("无解")
                    else:
                        if self._has_free_sym_in_sol_tuple(sol_list[0]):
                            self._show_result_label("有无穷多组解（存在自由变量）")
                        else:
                            sol = sol_list[0]
                            self._show_result_label("二元一次方程组的解：")
                            for var, val in zip((x, y), sol):
                                row = QWidget()
                                row_layout = QHBoxLayout(row)
                                row_layout.setContentsMargins(2,4,2,4)
                                var_label = QLabel(f"{var} = ")
                                row_layout.addWidget(var_label)
                                row_layout.addWidget(create_expression_widget(val))
                                row_layout.addStretch()
                                self.result_layout.addWidget(row)
                else:
                    sol_list = sp.solve(eqs, (x, y), dict=True)
                    if not sol_list:
                        check_inf = sp.linsolve([eq.lhs - eq.rhs for eq in eqs], (x,y))
                        if len(list(check_inf))>0 and self._has_free_sym_in_sol_tuple(list(check_inf)[0]):
                            self._show_result_label("有无穷多组解（存在自由变量）")
                        else:
                            self._show_result_label("无解")
                    else:
                        self._show_result_label("二元二次方程组的解：")
                        for idx, sol_dict in enumerate(sol_list):
                            group_label = QLabel(f"解 {idx+1}:")
                            group_label.setStyleSheet("font-weight:bold; margin-top:6px;")
                            self.result_layout.addWidget(group_label)
                            for var in (x, y):
                                val = sol_dict[var]
                                row = QWidget()
                                row_layout = QHBoxLayout(row)
                                row_layout.setContentsMargins(2,2,2,2)
                                var_label = QLabel(f"{var} = ")
                                row_layout.addWidget(var_label)
                                row_layout.addWidget(create_expression_widget(val))
                                row_layout.addStretch()
                                self.result_layout.addWidget(row)

            elif n_vars == 3:
                if len(eqs) != 3:
                    self._show_error(f"三元一次方程组需要恰好三个方程，当前读到 {len(eqs)} 个。")
                    return
                x, y, z = symbols_list[0], symbols_list[1], symbols_list[2]
                for eq in eqs:
                    try:
                        p = sp.Poly(eq.lhs - eq.rhs, x, y, z)
                        if p.total_degree() != 1:
                            self._show_error("三元模块仅支持三元一次方程组。")
                            return
                    except sp.PolynomialError:
                        self._show_error("检测到非多项式，三元仅支持一次多项式。")
                        return
                try:
                    sol_set = sp.linsolve([eq.lhs - eq.rhs for eq in eqs], (x, y, z))
                except Exception:
                    self._show_error("三元一次方程组求解失败。")
                    return
                sol_list = list(sol_set)
                if not sol_list:
                    self._show_result_label("无解")
                else:
                    if self._has_free_sym_in_sol_tuple(sol_list[0]):
                        self._show_result_label("有无穷多组解（存在自由变量）")
                    else:
                        sol = sol_list[0]
                        self._show_result_label("三元一次方程组的解：")
                        for var, val in zip((x, y, z), sol):
                            row = QWidget()
                            row_layout = QHBoxLayout(row)
                            row_layout.setContentsMargins(2,4,2,4)
                            var_label = QLabel(f"{var} = ")
                            row_layout.addWidget(var_label)
                            row_layout.addWidget(create_expression_widget(val))
                            row_layout.addStretch()
                            self.result_layout.addWidget(row)
            else:
                self._show_error(f"检测到 {n_vars} 个未知数，本工具仅支持1‑3元多项式方程。")
        except ValueError as ve:
            self._show_error(f"输入校验失败：{str(ve)}")
        except Exception as ge:
            self._show_error(f"求解异常：{str(ge)}")
        finally:
            self.result_container.setUpdatesEnabled(True)

    def _show_error(self, msg):
        QMessageBox.critical(self, "错误", msg)

    def _show_result_label(self, text):
        lbl = QLabel(text)
        lbl.setStyleSheet("font-weight: bold; margin-top: 12px; font-size:11pt;")
        self.result_layout.addWidget(lbl)


if __name__ == "__main__":
    app = QApplication(sys.argv)
    window = EquationSolver()
    window.show()
    sys.exit(app.exec())
