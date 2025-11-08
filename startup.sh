set -o pipefail

echo 'alias sc="SuperClaude"' >> ~/.bashrc
export PATH="/root/.local/bin:$PATH"
mkdir -p /root/.claude/plugins
ln -sf $(which SuperClaude) /root/.claude/plugins/sc || true

echo "🚀 Güncelleme kontrolü yapılıyor, ardından Claude Code başlatılacak..."
AUTO_START_CLAUDE=true exec bash /usr/local/bin/check_update.sh
