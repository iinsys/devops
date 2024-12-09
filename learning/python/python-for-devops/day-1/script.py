## 1 Scripting and Autmation
import shutil
import os

def backeup_folder(source_folder, backeup_folder):
    """
    Creates a backup folder of the specified source folder.
    """
    try:
        # Check if the source folder exists
        if not os.path.exists(source_folder):
            print(f"Error: Source folder '{source_folder}' does not exist")
            return
        
        # Create the backeup folder if it doesn't exist
        if not os.path.exists(backeup_folder):
            os.makedirs(backeup_folder)
        
        # Copy the source folder to the backeup folder
        shutil.copytree(source_folder, os.path.join(backeup_folder, os.path.basename(source_folder)))
        
    except Exception as e:
        print(f"Error: {str(e)}")
        
# Example
source_folder = "C:\\Users\\username\\Documents\\My Project"
backeup_folder = "C:\\Users\\username\\Documents\\My Project Backup"

backeup_folder(source_folder, backeup_folder)