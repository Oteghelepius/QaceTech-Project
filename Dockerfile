FROM ruby:2.7
WORKDIR /app
COPY Gemfile Gemfile.lock ./
RUN bundle install
COPY . .
ENV PORT=4567
EXPOSE 4567
CMD ["ruby", "app.rb", "-o", "0.0.0.0", "-p", "$PORT"]