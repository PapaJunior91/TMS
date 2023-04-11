#!/bin/sh

echo "🎬 entrypoint.sh: [$(whoami)] [PHP $(php -r 'echo phpversion();')]"

composer dump-autoload --no-interaction --no-dev --optimize

echo "🎬 artisan commands"

# link storage
php artisan storage:link

# 💡 Group into a custom command e.g. php artisan app:on-deploy
php artisan migrate:refresh

echo "🎬 start supervisord"

supervisord -c $LARAVEL_PATH/.deploy/config/supervisor.conf
