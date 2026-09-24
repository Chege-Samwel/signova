#!/bin/bash
cd "$HOME/git projects/signova/odoo17-theme-test"
echo "Making Signova views global (website_id=False) for demo..."
sudo docker compose exec -T web odoo shell -d signova_test --db_host=db --db_user=odoo --db_password=odoo --no-http -c /etc/odoo/odoo.conf << 'PYEOF'
print("=== Making views global ===")
views = env['ir.ui.view'].search([('name','ilike','signova')])
print(f"Found {len(views)} views, setting website_id=False")
for v in views:
    v.write({'website_id': False})
    print(f"  Set {v.name} (id={v.id}) to global")
assets = env['ir.asset'].search([('name','ilike','signova')])
print(f"Found {len(assets)} assets, setting website_id=False")
for a in assets:
    a.write({'website_id': False})
    print(f"  Set {a.name} to global")
env.cr.commit()
print("Committed, done")
PYEOF
echo "Restarting web..."
sudo docker compose restart web
sleep 15
echo "Checking after making global:"
curl -s http://localhost:8069/shop | grep -o "o_signova_theme\|o_signova_grid\|s_signova_hero" | wc -l
echo "o_signova_theme count:"
curl -s http://localhost:8069/shop | grep -o "o_signova_theme" | wc -l
echo "o_signova_grid count:"
curl -s http://localhost:8069/shop | grep -o "o_signova_grid" | wc -l
echo "s_signova_hero count:"
curl -s http://localhost:8069/ | grep -o "s_signova_hero" | wc -l
echo "Full wrap check:"
curl -s http://localhost:8069/shop | grep -o 'id="wrap"[^>]*' | head -2
