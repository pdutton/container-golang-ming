# ARG TAG=windowsservercore

FROM pdutton/7z:servercore-ltsc2022 as extractor

ADD https://github.com/niXman/mingw-builds-binaries/releases/download/12.2.0-rt_v10-rev2/x86_64-12.2.0-release-posix-seh-ucrt-rt_v10-rev2.7z C:/mingw.7z

RUN 7z x C:/mingw.7z

FROM golang:windowsservercore

COPY --from=extractor ["C:/mingw64","C:/Program Files/mingw64"]
RUN ["powershell", "setx", "/M", "PATH", "$($env:PATH + ';C:\\Program Files\\mingw64\\bin')"]

CMD [ "powershell" ]

