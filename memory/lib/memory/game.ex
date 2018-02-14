defmodule Memory.Game do
  def new do
    %{
      cards: init_cards(),  # card values
      indices: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15],
      show: [],             # indices of cards in display
      isGuess: false,
      isLock: false,
      lastCard: -1,
      completeNum: 0,
      numClicks: 0,
    }
  end

  # update the client view
  def client_view(game) do
    cards = game.cards
    indices = game.indices
    show = game.show
    %{
      memory: update_memory(cards, indices, show),
      isLock: game.isLock,
      isWin: checkWin(game.completeNum),
      score: compScore(game.numClicks),
    }
  end

  # handle the app state after client guesses
  def handle_guess(game, cur) do
    show = game.show
    isGuess = game.isGuess

    if Enum.any?(show, fn(x) -> x == cur end) do
      game
    else
      show = show ++ [cur]  # add current card in showing list.
      if !isGuess do  # in non-guess state
        game
        |> Map.put(:show, show)    # update show list
        |> Map.put(:isGuess, true) # change to guess state for next action
        |> Map.put(:lastCard, cur) # remember current card number

      else   # in guess state, i.e. clicking the second card in a round
        lastCard = game.lastCard
        numClicks = game.numClicks + 1  # one more guess
        cards = game.cards

        if Enum.at(cards, cur) == Enum.at(cards, lastCard) do # correct guess
          completeNum = game.completeNum + 2  # update number of guessed cards.
          game
          |> Map.put(:show, show)
          |> Map.put(:isGuess, false)
          |> Map.put(:lastCard, cur)
          |> Map.put(:completeNum, completeNum)
          |> Map.put(:numClicks, numClicks)

        else  # wrong guess
          # show the wrong pair for 1 second (lock state)
          game
          |> Map.put(:show, show)     # keep current memory temporarily
          |> Map.put(:isGuess, false)
          |> Map.put(:isLock, true)   # turn into lock state.
          |> Map.put(:numClicks, numClicks)
        end
      end
    end
  end

  # recover the previous state after locking for 1s.
  def handle_recover(game, cur) do
    lastCard = game.lastCard
    show = game.show -- [cur, lastCard]  # delete lastCard and current card from show list
    game
    |> Map.put(:show, show)
    |> Map.put(:isLock, false)  # recover to unlock state
    |> Map.put(:lastCard, cur)
  end

  # update the cards to display.
  def update_memory(cards, indices, show) do
    Enum.map indices, fn(i) ->
      if Enum.member?(show, i) do
        Enum.at(cards, i)
      else
        ""
      end
    end
  end

  # check whether the game wins or not.
  def checkWin(completeNum) do
    completeNum == 16
  end

  # compute the current score of the game.
  def compScore(numClicks) do
    100 - numClicks
  end

  # Generate a new set of cards randomly.
  def init_cards() do
    keys = ~w(
      A B C D E F G H
    )
    Enum.shuffle(keys ++ keys)
  end
end
