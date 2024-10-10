class CommisionService
  FIRST_LIMIT = 50 * 100
  SECOND_LIMIT = 300 * 100

  def initialize(amount_cents:)
    @amount_cents = amount_cents
  end

  def call
    if amount_cents < FIRST_LIMIT
      amount_cents * 0.01
    elsif amount_cents <= SECOND_LIMIT
      amount_cents * 0.0095
    else
      amount_cents * 0.0085
    end.to_i
  end

  private

  attr_reader :amount_cents
end
