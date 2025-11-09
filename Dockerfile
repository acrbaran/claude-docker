FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC

RUN apt-get update && apt-get install -y \
    curl bash ca-certificates git python3 python3-pip \
    && rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g npm@latest

RUN curl -fsSL https://claude.ai/install.sh | bash || true

RUN if [ -f "/root/.local/bin/claude" ]; then cp /root/.local/bin/claude /usr/local/bin/claude; fi && \
    if [ -f "/root/.claude/bin/claude" ]; then cp /root/.claude/bin/claude /usr/local/bin/claude; fi && \
    chmod +x /usr/local/bin/claude

RUN pip install --upgrade pip && pip install SuperClaude

RUN apt-get update && apt-get install -y expect && rm -rf /var/lib/apt/lists/* && \
    /usr/bin/expect <<'EOD'
    spawn SuperClaude install --force --yes
    set timeout -1
    expect {
        -re "Which" { send "all\r"; exp_continue }
        -re "Select" { send "all\r"; exp_continue }
        -re "Proceed" { send "y\r"; exp_continue }
        -re "overwrite" { send "y\r"; exp_continue }
        eof
    }
EOD

RUN apt-get update && apt-get install -y util-linux
RUN mkdir -p /root/.claude/plugins && \
    ln -s $(which SuperClaude) /root/.claude/plugins/sc || true

RUN echo 'alias sc="SuperClaude"' >> ~/.bashrc

ENV CLAUDE_HOME=/root/.claude
ENV CLAUDE_DISABLE_PLUGINS=true
ENV PATH="/root/.local/bin:/usr/local/bin:$PATH"

WORKDIR /workspace

COPY check_update.sh /usr/local/bin/check_update.sh
COPY update_now.sh /usr/local/bin/update_now.sh
RUN chmod +x /usr/local/bin/check_update.sh /usr/local/bin/update_now.sh
COPY recommend.md /root/.claude/commands/sc/recommend.md

RUN echo 'if [ -t 1 ]; then bash /usr/local/bin/check_update.sh; fi' >> /root/.bashrc

CMD ["bash", "-l"]