set -e

LOG_FILE="/tmp/sc_update.txt"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

AUTO_START=false
if [ "$1" == "--auto-start" ] || [ "$AUTO_START_CLAUDE" == "true" ]; then
  AUTO_START=true
fi

if [ "$AUTO_START" != "true" ]; then
  exec > >(tee -a "$LOG_FILE") 2>&1
fi

echo -e "${BLUE}🔍 SuperClaude sürümü kontrol ediliyor...${NC}"

LATEST=$(pip index versions SuperClaude 2>/dev/null | grep -oP 'Available versions: \K.*' | awk -F',' '{print $1}' | tr -d '[:space:]')
CURRENT=$(pip show SuperClaude 2>/dev/null | grep Version | awk '{print $2}' | tr -d '[:space:]')

LATEST=$(echo "$LATEST" | sed 's/[^0-9\.]//g')
CURRENT=$(echo "$CURRENT" | sed 's/[^0-9\.]//g')

if [ -z "$LATEST" ] || [ -z "$CURRENT" ]; then
  echo -e "${YELLOW}⚠️  SuperClaude sürüm bilgisi alınamadı.${NC}"
else
  ORDER=$(printf "%s\n%s" "$CURRENT" "$LATEST" | sort -V | head -n1)
  if [ "$ORDER" = "$LATEST" ] && [ "$CURRENT" != "$LATEST" ]; then
    echo -e "${RED}🚨 Yeni SuperClaude sürümü bulundu: $LATEST (şu anki: $CURRENT)${NC}"
    
    if [ "$AUTO_START" = "true" ]; then
      echo -e "${YELLOW}⏩ Otomatik mod: Güncelleme atlandı, Claude başlatılıyor...${NC}"
    else
      echo
      echo -e "${YELLOW}🟡 Ne yapmak istersin?${NC}"
      echo " [1] SuperClaude'u Güncelle"
      echo " [2] Güncellemeyi Atla"
      echo " [3] Çık"
      echo
      read -p "Seçimin (1/2/3): " choice

      case $choice in
        1)
          echo -e "${BLUE}⏫ SuperClaude güncelleniyor...${NC}"
          bash /usr/local/bin/update_now.sh
          echo -e "${GREEN}✅ Güncelleme tamamlandı!${NC}"
          ;;
        2)
          echo -e "${YELLOW}⏩ Güncelleme atlandı.${NC}"
          ;;
        3)
          echo -e "${RED}🚪 Çıkılıyor...${NC}"
          exit 0
          ;;
        *)
          echo -e "${YELLOW}⚠️  Geçersiz seçim, güncelleme atlandı.${NC}"
          ;;
      esac
    fi
  else
    echo -e "${GREEN}✅ SuperClaude güncel ($CURRENT)${NC}"
  fi
fi

echo
echo -e "${GREEN}✅ Güncelleme kontrolü tamamlandı.${NC}"

echo -e "${BLUE}🚀 Claude Code başlatılıyor...${NC}"
sleep 0.5
script -q -c "claude" /dev/null
