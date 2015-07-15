class Player

  ROYALS = %W[K Q J]

  def initialize(hand)
    @hand = hand
  end

  def hit(card)
    @hand << card
  end

  def hand_value
    value = 0

    @hand.each do |card|
      if ROYALS.include?(card[1])
        value += 10
      elsif card[1] = 'A'
        if value + 11 > 21
          value += 1
        else
          value += 11
        end
      else
        value += card[1]
      end
    end
    value
  end

end