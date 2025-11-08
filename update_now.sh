set -e
RED='\033[0;31m'; GREEN='\033[0;32m'; NC='\033[0m'

echo -e "${GREEN}⏫ SuperClaude güncelleniyor...${NC}"
pip install --upgrade SuperClaude --break-system-packages -q
echo -e "1\ny\n" | SuperClaude update --force --yes || true
echo -e "${GREEN}✅ SuperClaude başarıyla güncellendi.${NC}"