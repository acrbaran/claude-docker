# 🐳 Claude Docker

Claude Code CLI ve SuperClaude framework'ünü birleştiren, Türkçe arayüze sahip Dockerize edilmiş bir geliştirme ortamı. Otomatik güncelleme yönetimi ve çok katmanlı yapılandırma sistemi sunar.

## ✨ Özellikler

- 🚀 **Zero-Konfigürasyon**: Tek komut ile çalıştırma
- 🔄 **Otomatik Güncelleme**: Sürekli güncel SuperClaude sürümü
- 🛡️ **Güvenli İzolasyon**: Konfigürasyon güvenliği
- 🇹🇷 **Türkçe Arayüz**: Yerelleştirilmiş kullanıcı deneyimi
- 📊 **Volume Kalıcılığı**: Veri güvenliği ve süreklilik

## 🏗️ Sistem Mimarisi

- **Temel Image**: Ubuntu 22.04 üzerinde Node.js 22.x, Python 3 ve Git
- **Çekirdek Entegrasyon**: Claude Code CLI ile SuperClaude framework entegrasyonu
- **Güncelleme Sistemi**: Otomatik sürüm kontrolü ve isteğe bağlı güncellemeler
- **Yerelleştirme**: Türkçe arayüz ve mesajlaşma sistemi

## 📁 Proje Yapısı

```
claude-docker/
├── 🐳 Dockerfile              # Konteyner build spesifikasyonu
├── 🚀 docker-compose.yml      # Servis orkestrasyonu
├── 🔧 .env                    # Ortam değişkenleri
├── ⚡ startup.sh              # Konteyner başlatma ve SuperClaude kurulumu
├── 🔄 check_update.sh         # Sürüm takibi ve güncelleme yönetimi
├── 📦 update_now.sh           # Güncelleme çalıştırma mantığı
└── 📚 CLAUDE.md               # Proje dokümantasyonu
```

## 🚀 Hızlı Başlangıç

### 1. Ortam Değişkenlerini Yapılandır
`.env` dosyasını oluşturun:
```bash
ANTHROPIC_BASE_URL=https://api.z.ai/api/anthropic
ANTHROPIC_AUTH_TOKEN=your_token_here
CLAUDE_CODE_SKIP_AUTH_LOGIN=1
ANTHROPIC_DEFAULT_SONNET_MODEL=glm-4.6
ANTHROPIC_DEFAULT_OPUS_MODEL=glm-4.6
ANTHROPIC_DEFAULT_HAIKU_MODEL=glm-4.5-air
LOCAL_PATH=/Users/baran
```

### 2. Konteyneri Başlat
```bash
docker-compose up -d --build
```

### 3. Claude Code'a Bağlan
```bash
docker-compose exec claude bash
```

## 🔧 Kullanım Komutları

### Geliştirme Ortamı
```bash
# Konteyneri build et ve başlat
docker-compose up -d --build

# Çalışan konteynere eriş
docker-compose exec claude bash

# Konteyner loglarını görüntüle
docker-compose logs -f claude

# Konteyneri durdur
docker-compose down
```

### Güncelleme Yönetimi
```bash
# Manuel güncelleme kontrolü (konteyner içinde)
/usr/local/bin/check_update.sh

# Zorla güncelleme (konteyner içinde)
/usr/local/bin/update_now.sh

# SuperClaude komutları
sc help
sc update
```

## 🔄 Otomatik Güncelleme Sistemi

Konteyner her başlatıldığında:
1. ✅ SuperClaude sürümünü kontrol eder
2. 🔍 Yeni sürüm varsa güncelleme seçeneği sunar
3. 🚀 Claude Code'u güncel sürümle başlatır
4. 📊 İşlemi Türkçe arayüzde yönetir

## 🛡️ Güvenlik Özellikleri

- **Konfigürasyon İzolasyonu**: Claude ayarları ayrı volume'da saklanır
- **Eklenti Yönetimi**: Güvenlik için `CLAUDE_DISABLE_PLUGINS=true`
- **API Güvenliği**: Token yönetimi ve özel endpoint desteği
- **Kapsayıcı Güvenliği**: Ubuntu 22.04 güvenlik güncellemeleri

## 📚 Dokümantasyon

- **[Proje Dokümantasyonu](./PROJE_DOKUMANTASYONU.md)** - Detaylı sistem mimarisi
- **[API ve Yapı Dokümantasyonu](./API_YAPI_DOKUMANTASYONU.md)** - Teknik detaylar
- **[İndeks ve Navigasyon](./INDEX_NAVIGASYONU.md)** - Kapsamlı rehber
- **[CLAUDE.md](./CLAUDE.md)** - Claude Code kullanım rehberi

## 🤝 Katkıda Bulunma

1. Bu repoyu fork edin
2. Özellik branch'ini oluşturun (`git checkout -b feature/yeni-ozellik`)
3. Değişikliklerinizi commit edin (`git commit -am 'Yeni özellik eklendi'`)
4. Branch'inizi push edin (`git push origin feature/yeni-ozellik`)
5. Bir Pull Request oluşturun

## 📄 Lisans

Bu proje MIT lisansı altında dağıtılmaktadır.

## 🌟 Özellikler

- 🚀 **Otomatik Güncelleme**: Sürekli güncel SuperClaude sürümü
- 🇹🇷 **Türkçe Destek**: Tamamen yerelleştirilmiş arayüz
- 🛡️ **Güvenli İzolasyon**: Konfigürasyon güvenliği
- 📊 **Volume Yönetimi**: Veri kalıcılığı ve yedekleme
- 🔧 **Zero-Konfigürasyon**: Hızlı kurulum ve başlatma

---

**⚡ Claude Docker ile AI destekli geliştirmeye hemen başlayın!**