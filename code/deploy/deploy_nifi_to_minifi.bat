@ECHO OFF
SET version=0.5.0
docker inspect itarano/minifi-toolkit:%version% 2> nul 1> nul || docker pull itarano/minifi-toolkit:%version% 1> nul
SET file=%1
SET path_volume=%cd%
IF [%file%]==[] (echo Need a file to transform) ELSE (docker run --rm --volume %path_volume%:/templates -it itarano/minifi-toolkit:%version% /opt/minifi-toolkit/bin/config.sh transform /templates/%file:.\=% /templates/config.yml)
docker rmi minifi-toolkit:%version% 1> nul
ECHO.
IF EXIST "%cd%\config.yml" (ECHO Deployed... && COPY /Y config.yml ..\..\docker\volumes\minifi\conf\templates\ 1>nul && DEL config.yml)
