#!/bin/bash
cd "$HOME/git projects/signova/odoo17-theme-test"
echo "Running view diagnostic..."
sudo docker compose exec -T web odoo shell -d signova_test --db_host=db --db_user=odoo --db_password=odoo --no-http -c /etc/odoo/odoo.conf << 'PYEOF'
print("=== Checking ir.ui.view for Signova templates ===")
views = env['ir.ui.view'].search([('name','ilike','signova')])
print(f"Found {len(views)} views")
for v in views:
    print(f"  ID={v.id} name={v.name} key={v.key} website_id={v.website_id.name if v.website_id else False} (id={v.website_id.id if v.website_id else False}) active={v.active} inherit={v.inherit_id.name if v.inherit_id else False}")
print("\n=== Checking website ===")
websites = env['website'].search([])
for w in websites:
    print(f"  ID={w.id} name={w.name} domain={w.domain}")
print("\n=== Checking ir.asset ===")
assets = env['ir.asset'].search([('name','ilike','signova')])
print(f"Found {len(assets)} assets")
for a in assets:
    print(f"  {a.name} path={a.path} bundle={a.bundle} website_id={a.website_id.name if a.website_id else False}")
print("\n=== Checking body class view ===")
body_view = env.ref('signova_ecommerce_theme.body_signova_class', raise_if_not_found=False)
if body_view:
    print(f"body_signova_class: id={body_view.id} website_id={body_view.website_id.name if body_view.website_id else False} arch={body_view.arch[:500]}")
else:
    print("body_signova_class NOT FOUND")
print("\n=== Checking shop view ===")
shop_view = env.ref('signova_ecommerce_theme.shop_signova_grid_tweak', raise_if_not_found=False)
if shop_view:
    print(f"shop_signova_grid_tweak: id={shop_view.id} website_id={shop_view.website_id.name if shop_view.website_id else False} active={shop_view.active}")
    print(f"arch: {shop_view.arch[:500]}")
else:
    print("shop_signova_grid_tweak NOT FOUND")
PYEOF
