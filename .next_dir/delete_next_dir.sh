@echo off

echo WARNING: This script will delete ALL .next folders in the current directory and its subdirectories,
echo          EXCEPT those inside node_modules directories.
echo.
set /p confirm="Are you sure you want to continue? (y/n): "

if /i "%confirm%"=="y" (
    echo Searching for .next folders to delete, excluding node_modules...
    
    set deletedcount=0

    for /d /r %%d in (.next) do (
        :: Check if the directory is inside node_modules
        echo %%d | findstr /i "\\node_modules\\" >nul
        if errorlevel 1 (
            echo Deleting "%%d"...
            rd /s /q "%%d"
            set /a deletedcount+=1
        ) else (
            echo Skipping "%%d" inside node_modules...
        )
    )

    echo.
    echo Deletion complete. %deletedcount% .next directories (excluding those in node_modules) have been deleted.
    pause
) else (
    echo Operation cancelled by user.
    pause
)