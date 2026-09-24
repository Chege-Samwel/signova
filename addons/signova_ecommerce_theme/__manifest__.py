{
    'name': 'Signova E-commerce Theme',
    'version': '18.0.5.2.29',
    'category': 'Website/Website',
    'summary': 'Fix 0 count - aggressive cleanup + direct CSS',
    'description': """
v18.0.5.2.29 - Fixes 0 count for o_signova_theme/grid/hero:

User: v2.28 still 0 counts after making global, shop still broken vertical text, category squares on shop

Root:
- Pre-migrate only kept MAX per name, but old duplicate views without path check still remain (31 views)
- SCSS fixes nested under .o_signova_theme, but body doesn't have class, so no CSS applies
- FIX_GLOBAL.sh 404 after force push (file missing)
- @class warning

Fix v2.29:
- Aggressive cleanup in pre-migrate: DELETE ALL Signova views (not just duplicates) then recreate fresh
  DELETE FROM ir_ui_view WHERE name ILIKE '%%signova%%'
- All templates priority 999, unconditional, with path == '/' check for homepage only
  body_signova_class adds o_signova_theme always
  shop_signova_grid_tweak adds o_signova_grid + o_signova_theme to wrap
- SCSS: 
  * Restored original 1095 lines navy #0b1f3a gold #c9a227
  * Added fixes INSIDE theme block (for when body has class)
  * Added fixes OUTSIDE theme block (direct targeting, works even if body no class)
    - Vertical text horizontal-tb
    - Gold icons #ffcc00
    - Shop 5/3/2 cols
- Re-added FIX_GLOBAL.sh with env.cr syntax
- Fixed xpath hasclass not contains

Should fix 0 count and make shop mirror New Arrivals
""",
    'author': 'Signova',
    'website': 'https://signova.store',
    'license': 'LGPL-3',
    'depends': ['website_sale', 'product'],
    'data': [
        'security/ir.model.access.csv',
        'views/product_data_views.xml',
        'views/website_templates.xml',
        'views/homepage_marketplace.xml',
        'views/faq_page.xml',
        'data/assets.xml',
        'data/faqs.xml',
    ],
    'installable': True,
    'application': False,
    'auto_install': False,
    'post_init_hook': 'post_init_hook',
}
