#!/bin/bash
set -e
PROJECT_DIR="$HOME/git projects/signova/odoo17-theme-test"
cd "$PROJECT_DIR"
echo "Downloading v2.29 FIX 0 COUNT - aggressive cleanup + direct CSS..."
curl -L -H "Cache-Control: no-cache" -o new.zip "https://github.com/Chege-Samwel/signova/raw/arena/01a0d45a-signova/signova_ecommerce_theme_v18.0.5.2.29.zip?cb=$(date +%s)"
unzip -p new.zip signova_ecommerce_theme/__manifest__.py | grep version
sudo rm -rf /tmp/signova_ecommerce_theme
unzip -o new.zip -d /tmp/
sudo rm -rf ./addons/signova_ecommerce_theme
sudo cp -r /tmp/signova_ecommerce_theme ./addons/
sudo chown -R 1000:1000 ./addons
sudo chmod -R 755 ./addons
sudo docker compose restart web
sleep 20
sudo docker compose exec -T web odoo -u signova_ecommerce_theme -d signova_test --db_host=db --db_user=odoo --db_password=odoo --stop-after-init || echo "Check logs"
echo "Verify after aggressive cleanup:"
curl -s http://localhost:8069/shop | grep -o "o_signova_theme" | wc -l
curl -s http://localhost:8069/shop | grep -o "o_signova_grid" | wc -l
curl -s http://localhost:8069/ | grep -o "s_signova_hero" | wc -l
echo "Open http://localhost:8069/shop?debug=assets hard refresh"
