require 'test_helper'

class PredictionComponentTest < ViewComponent::TestCase
  test 'past game doesnt render' do
    prediction = predictions(:diego_game_1)

    before_game_25 do
      component = PredictionComponent.new(prediction: prediction)
      render_inline(component)
      assert page.text.empty?, 'should not have rendered'
    end
  end

  test '.render, unpredicted game' do
    prediction = predictions(:diego_game_27)

    before_game_25 do
      component = PredictionComponent.new(prediction: prediction)
      render_inline(component)
      assert_selector 'button', text: 'Start'
    end
  end

  test '.render, predicted game' do
    prediction = predictions(:diego_game_1)

    before_tournament do
      component = PredictionComponent.new(prediction: prediction)
      render_inline(component)
      assert_selector 'button', text: '+', count: 2
      assert_selector 'button', text: '-', count: 2
    end
  end
end
