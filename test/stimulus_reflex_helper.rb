module StimulusReflexHelper
  def wait_for_stimulus_reflex(seconds: 2, sleep_time: 0.1)
    max_iterations = (seconds / sleep_time).to_i
    iterations = 0

    while iterations < max_iterations
      break if find('body')['data-sr-connected'].present?

      sleep sleep_time
      iterations += 1
    end

    raise "Stimulus Reflex NOT connected after #{seconds} seconds" if max_iterations == iterations

    Rails.logger.info "Stimulus Reflex connected after #{iterations * sleep_time} seconds"
  end

  def listen_to_stimulus_reflex
    execute_script(add_event_listener)
    Rails.logger.info 'Added Event Listener for stimulus-reflex:connected'
  rescue Capybara::NotSupportedByDriverError
    # That's OK, for example if driver :rack_test
  end

  def add_event_listener
    <<~JS
      document.addEventListener('stimulus-reflex:connected', () => {
        const body = document.querySelector('body');
        const timesConnected = parseInt(body.dataset.srConnected || 0);
        body.dataset.srConnected = timesConnected + 1;
      });
    JS
  end
end
