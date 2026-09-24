def migrate(cr, version):
    import logging
    _logger=logging.getLogger(__name__)
    _logger.info("=== v2.29 post-migrate ===")
    try:
        cr.execute("DELETE FROM ir_attachment WHERE url LIKE '%%assets_frontend%%' OR url LIKE '%%web.assets%%'")
        _logger.info("Cleared assets")
    except Exception as e:
        _logger.warning("Clear failed: %s", e)
        try:
            cr.rollback()
        except:
            pass
