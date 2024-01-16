# kizzycode/php

A Debian-based, self-contained PHP application server image (php-fpm, nginx).

### Container users
Container users may interact with the external environment via mountpoints:
- `www-data`: A system user for the webserver and php; it has UID `10000`
