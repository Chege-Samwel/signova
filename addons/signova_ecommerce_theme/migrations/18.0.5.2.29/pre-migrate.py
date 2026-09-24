def migrate(cr, version):
    import logging
    _logger=logging.getLogger(__name__)
    _logger.info("=== v2.29 pre-migrate: aggressive cleanup for 0 count ===")
    try:
        # Aggressive: delete ALL old Signova views to ensure fresh creation
        cr.execute("DELETE FROM ir_ui_view WHERE name ILIKE '%%signova%%'")
        _logger.info("Deleted all old Signova views for fresh recreation")
        cr.execute("DELETE FROM ir_model_data WHERE name LIKE '%%signova%%' AND module='signova_ecommerce_theme'")
        _logger.info("Deleted old ir_model_data")
    except Exception as e:
        _logger.warning("Aggressive cleanup failed: %s", e)
        try:
            cr.rollback()
        except:
            pass
