# frozen_string_literal: true

def fill_new_query(query, sleep_time: 0.1)
  fill_in 'query', with: query
  find("input[name='commit']").click
  sleep(sleep_time)
end
