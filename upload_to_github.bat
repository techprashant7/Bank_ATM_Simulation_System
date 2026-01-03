@echo off
echo Uploading Bank ATM System to GitHub...
echo.

echo Step 1: Create a GitHub Personal Access Token
echo 1. Go to: https://github.com/settings/tokens
echo 2. Click "Generate new token (classic)"
echo 3. Check "repo" permissions
echo 4. Generate token and copy it
echo.
pause

set /p token="Enter your GitHub token: "

echo.
echo Step 2: Uploading to GitHub...
git push https://techprashant7:%token%@github.com/techprashant7/Bank_ATM_Simulation_System.git main

echo.
echo Done! Your code should now be on GitHub at:
echo https://github.com/techprashant7/Bank_ATM_Simulation_System
pause
