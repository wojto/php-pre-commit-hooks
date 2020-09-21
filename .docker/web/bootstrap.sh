# install git hooks if not exists
if [ ! -f "/var/www/html/.git/hooks/pre-commit" ]; then
    echo "Installing git hooks"
    cp /var/www/html/.docker/web/git/hooks/pre-commit /var/www/html/.git/hooks/pre-commit
fi

# keep apache in background
/usr/local/bin/apache2-foreground