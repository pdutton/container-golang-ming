# ARG TAG=windowsservercore

FROM pdutton/7z:servercore-ltsc2022 as extractor

ADD https://github.com/niXman/mingw-builds-binaries/releases/download/13.1.0-rt_v11-rev1/x86_64-13.1.0-release-posix-seh-ucrt-rt_v11-rev1.7z C:/mingw.7z

RUN 7z x C:/mingw.7z

FROM golang:1.21

COPY --from=extractor ["C:/mingw64","C:/Program Files/mingw64"]
RUN ["powershell", "setx", "/M", "PATH", "$($env:PATH + ';C:\\Program Files\\mingw64\\bin')"]

CMD [ "powershell" ]

