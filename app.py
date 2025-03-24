import streamlit as st
import subprocess

def run_script(arg1, arg2):
    log_placeholder = st.empty()

    script_args = [arg1, arg2]

    process = subprocess.Popen(
        ["bash", "src/backup.sh"] + script_args,
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

arg1 = st.text_input("Source", "src")
arg2 = st.text_input("Destination", "backup")

if st.button("Run Backup"):
    run_script(arg1, arg2)
