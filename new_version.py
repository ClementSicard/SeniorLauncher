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
    new_string = "<!--" + version
    new_content = f_content.replace(f_content[version_match.start(
        0): closing_idx], new_string)
    f.seek(0)
    f.truncate()
    f.write(new_content)
    f.close()
    current_path = os.getcwd()
    os.chdir("/Users/clementsicard/Dev/GitHub/AppInstaller")
    os.system(
        "git commit -am \"[Automatic commit - update bot] Updated index.html to version " + version + "\"")
    os.system("git push")
    os.chdir(current_path)


def upload_update_to_dropbox(app_name):
    parser = configparser.ConfigParser()
    parser.read('dropbox_credentials.ini')
    token = parser.get('dropbox', 'token')

    dbx = dropbox.Dropbox(token)
    apk_path = path + "\\build\\app\\outputs\\apk\\release\\app-release.apk"
    apk = open(apk_path, "rb")

    print("\nUploading new apk (version " + version + " to Dropbox ...")
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
            "git commit -am \"[Automatic commit - update bot] Updated pubspec to version " + version + "\"")
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
            "git commit -am \"[Automatic commit - update bot] Updated home_page.dart to version " + version + "\"")
    else:
        print("Bizarre ce qu'il se passe")


path = "/Users/clementsicard/Dev/GitHub/SeniorLauncher"

version = sys.argv[1]
os.chdir(path)


print("\n\n1. UPDATING pubspec.yaml\n_______________________\n\n")
update_pubspec(version, 'pubspec.yaml')

print("\n\n2. UPDATING CHECK IN home_page.dart\n_______________________\n\n")
update_checker(version, 'lib\\utils\\constants.dart')

print("\n\n3. BUILDING APK FILE\n_______________________\n\n")
os.system("flutter build apk")

print("\n\n4. UPLOADING FILE TO DROPBOX\n_______________________\n\n")
upload_update_to_dropbox("SeniorLauncher.apk")

print("\n\n5. UPDATING github.io\n_______________________\n\n")
update_githubio(
    version, "/Users/clementsicard/Dev/GitHub/AppInstaller/index.html")

print("\n\n6. PUSHING CHANGES TO GITHUB REPOSITORY\n_______________________\n\n")
os.system("git push")

print("Done!")
