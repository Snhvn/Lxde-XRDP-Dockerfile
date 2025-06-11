FROM debian:12
ARG ngrokid
ENV ngrokid=${ngrokid}

RUN apt update && apt install openssh-server lxde xrdp sudo neofetch systemctl wget curl python3-pip -y > /dev/null 2&1
RUN echo "lxsession -s LXDE -e LXDE" >> /etc/xrdp/startwm.sh
RUN sed -i "s/port=3389/port=3389/g" /etc/xrdp/xrdp.ini
RUN service xrdp restart

RUN mkdir -p /dsc.gg/servertipacvn && echo "Ngrok Session Running... Subscribe: https://youtube.com/@snipavn | Server Support: https://dsc.gg/servertipacvn" > /app/index.html
WORKDIR /dsc.gg/servertipacvn

#cài ngrok
RUN curl -s https://ngrok-agent.s3.amazonaws.com/ngrok.asc | sudo tee /etc/apt/trusted.gpg.d/ngrok.asc >/dev/null && echo "deb https://ngrok-agent.s3.amazonaws.com buster main" | sudo tee /etc/apt/sources.list.d/ngrok.list && sudo apt update && sudo apt install ngrok && \
    ngrok config add-authtoken ${ngrokid}

EXPOSE 3389 8080 2222 22 6080 5900 3388

CMD python3 -m http.server 6080 & \
    echo "Ngrok Running ... Please Check Agents ngrok.com and please connect Rdp" && ngrok tcp 3389 --region ap
