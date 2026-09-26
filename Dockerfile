# Static page, no build step: nginx-unprivileged serves site/ as-is.
# uid 101, plain HTTP on 8080, TLS terminated upstream by traefik +
# cert-manager. Source CI publishes the git-sha image; coilyco/deploy owns
# rollout.
FROM nginxinc/nginx-unprivileged:1.27-alpine

COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY site/ /usr/share/nginx/html/
