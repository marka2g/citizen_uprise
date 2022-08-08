defmodule CitizenUprise.Donations do
  def calculate_remaining(partial_donation) do
    IO.inspect(partial_donation, label: "partial_donation")
  end

  def calculate_max do
    # max={@donation/@candidate_count }
  end

end

# def calculate(seats) do
#   if seats <= 5 do
#     seats * 20.0
#   else
#     100 + (seats - 5) * 15.0
#   end
# end
