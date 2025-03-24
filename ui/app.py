import streamlit as st
import subprocess
import os

st.set_page_config(page_title="Backup Manager", page_icon="🔄", layout="wide")

st.title("Backup Manager")

def run_script(arg1, arg2):
    log_placeholder = st.empty()

    script_args = [arg1, arg2]

    process = subprocess.Popen(
        ["bash", "/scripts/backup.sh"] + script_args,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        bufsize=1,
        universal_newlines=True
    )

    log_output = ""
    with process.stdout as stdout, process.stderr as stderr:
        for line in stdout:
            log_output += line.strip() + "\n"
            log_placeholder.markdown(f"```bash\n{log_output}```", unsafe_allow_html=True)
        for line in stderr:
            log_output += line.strip() + "\n"
            log_placeholder.markdown(f"```bash\n{log_output}```", unsafe_allow_html=True)

backup_source = os.getenv("SRC_PATH", "/source/")
backup_destination = os.getenv("BACKUP_PATH", "/backup/")

arg1 = st.text_input("Source", backup_source)
arg2 = st.text_input("Destination", backup_destination)

if st.button("Run Backup"):
    run_script(arg1, arg2)
