import dropbox
from dropbox.files import WriteMode
import sys
import os
import configparser
import re


def update_githubio(version, file_path):
    f = open(file_path, "r+")
    f_content = f.read()
    version_match = re.search("-->\n<!--", f_content)
    closing_idx = version_match.end(0)
    while f_content[closing_idx] != '-':
        closing_idx += 1
    new_string = "\n<!--" + version
    new_content = f_content.replace(f_content[version_match.start(
        0) + 3: closing_idx], new_string)
    f.seek(0)
    f.truncate()
    f.write(new_content)
    f.close()
    current_path = os.getcwd()
    os.chdir("/Users/clementsicard/Dev/GitHub/AppInstaller")
    os.system(
        "git commit -am \"[Automatic commit - update bot] Updated index.html to version " + version + "\" &> /dev/null")
    os.system("git push &> /dev/null")
    os.chdir(current_path)


def upload_update_to_dropbox(app_name):
    parser = configparser.ConfigParser()
    parser.read('dropbox_credentials.ini')
    token = parser["DROPBOX"]["token"]

    dbx = dropbox.Dropbox(token)
    apk_path = path + "/build/app/outputs/apk/release/app-release.apk"
    apk = open(apk_path, "rb")

    print("\nUploading new apk (version " + version + ") to Dropbox ...")
    dbx.files_upload(apk.read(),
                     "/" + app_name, mode=WriteMode('overwrite'))
    print("Done !")
    apk.close()


def update_pubspec(version, file_path):
    f = open(file_path, "r+")
    f_content = f.read()
    version_match = re.search("\nversion: ", f_content)
    closing_idx = version_match.end(0)
    while f_content[closing_idx] != '\n':
        closing_idx += 1
    new_content = f_content.replace(f_content[version_match.end(
        0): closing_idx + 1], version + '\n')

    if f_content[version_match.end(
            0): closing_idx + 1] != version + '\n':
        os.system(
            "git commit -am \"[Automatic commit - update bot] Updated pubspec to version " + version + "\" &> /dev/null")
    f.seek(0)
    f.truncate()
    f.write(new_content)
    f.close()


def update_checker(version, file_path):
    f = open(file_path, "r+")
    f_content = f.read()
    version_match = re.search("static const CURRENT_VERSION = ", f_content)
    closing_idx = version_match.end(0)
    while f_content[closing_idx] != '\n':
        closing_idx += 1
    new_content = f_content.replace(f_content[version_match.end(
        0): closing_idx + 1], "'" + version + "';" + '\n')
    f.seek(0)
    f.truncate()
    f.write(new_content)
    f.close()
    if f_content[version_match.end(
            0): closing_idx + 1] != "'" + version + "';'\n":
        os.system(
            "git commit -am \"[Automatic commit - update bot] Updated constants to version " + version + "\" &> /dev/null")
    else:
        print("Bizarre ce qu'il se passe")


path = "/Users/clementsicard/Dev/GitHub/SeniorLauncher"

version = sys.argv[1]
os.chdir(path)


print("1. Updating 'pubspec.yaml' with new version")
update_pubspec(version, 'pubspec.yaml')

print("2. Updating version in 'constants.dart'")
update_checker(version, "lib/utils/constants.dart")

print("3. Building .apk file")
os.system("flutter build apk > /dev/null")

print("4. Uploading .apk to Dropbox")
upload_update_to_dropbox("SeniorLauncher.apk")

print("5. Updating 'github.io'")
update_githubio(
    version, "/Users/clementsicard/Dev/GitHub/AppInstaller/index.html")

print("6. Pushing changes to GitHub repository")
os.system("git push &> /dev/null")

print("\nDone!")
