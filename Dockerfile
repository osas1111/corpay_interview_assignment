# Dockerfile.rails
FROM ruby:3.2.2-alpine AS builder

# Install related packages and build the application dependencies
RUN apk add \
  build-base \
  sqlite \
  mariadb-dev
COPY Gemfile* ./
RUN bundle install

FROM ruby:3.2.2-alpine AS runner

# Install related packages
RUN apk add \
  mariadb-dev \
  sqlite \
  tzdata \
  nodejs

# Set default working directory and user
ENV APP_PATH /app
RUN mkdir -p $APP_PATH
RUN addgroup -S app && adduser -S -G app app

WORKDIR $APP_PATH

# Copy application files and dependencies from previous step
COPY --from=builder /usr/local/bundle/ /usr/local/bundle/
COPY . ./

RUN chown -R app:app .

USER app

# Entrypoint prepares the database.
ENTRYPOINT ["./docker-entrypoint.sh"]

# Start the server by default, this can be overwritten at runtime
EXPOSE 3000
CMD ["./bin/rails", "server", "-p", "3000", "-b", "0.0.0.0"]
