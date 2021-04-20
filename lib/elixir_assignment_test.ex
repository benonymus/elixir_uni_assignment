defmodule User do
  defstruct name: "John", age: 27
end

defmodule ElixirAssignmentTest do
  @moduledoc """
  Documentation for `ElixirAssignmentTest`.
  """

  def test() do
    as = [{:t, 0}, {:g, 0}, {:c, 0}, {:a, 0}, {:a, 0}, {:t, 0}, {:c, 0}]
    bs = [{:t, 0}, {:g, 0}, {:t, 0}, {:t, 0}, {:a, 0}, {:a, 0}, {:t, 0}]
    calc(0, as, bs)
  end

  def calc(cv, [], []) do
    cv
  end

  def calc(cv, as, bs) do
    [{aa, av} | _] = as
    [{ba, bv} | _] = bs
    [{_, xv} | as] = line(cv, ba, bv, as)
    [{_, ^xv} | bs] = line(cv, aa, av, bs)
    calc(xv, as, bs)
  end

  def line(_, _, _, []) do
    []
  end

  def line(cv, ba, bv, [{aa, av} | rest]) do
    bv = sw(cv, {ba, bv}, {aa, av})
    [{aa, bv} | line(av, ba, bv, rest)]
  end

  def sw(cv, {ba, bv}, {aa, av}) do
    max(cv + s(aa, ba), max(av, bv))
  end

  def s(a, a) do
    1
  end

  def s(_, _) do
    -1
  end

  # checksum sequence
  def check_sum(numbers) do
    numbers
    |> multiply_values
    |> break_double_digits
    |> sum_numbers
    |> calulate_last_digit
  end

  # header function to set acc
  defp multiply_values(_, acc \\ [])

  # if there are 2 digits souble first return second
  defp multiply_values([x, y | rest], acc) do
    x = x * 2
    y = y
    acc = append(acc, [x, y])
    multiply_values(rest, acc)
  end

  # if there is one digit double it
  defp multiply_values([x], acc) do
    x = x * 2
    append(acc, [x])
  end

  # header function to set acc
  defp break_double_digits(_, acc \\ [])

  # if the list is empty return acc
  defp break_double_digits([], acc) do
    acc
  end

  # if digit is bigger than 9 then break it up else add it to acc
  defp break_double_digits([x | rest], acc) do
    if x > 9 do
      digits = break_number(x)
      break_double_digits(rest, append(acc, digits))
    else
      break_double_digits(rest, append(acc, [x]))
    end
  end

  # we know that the highest number possible is 18, so by subtracting 10 we get the second digit and we know the first is always 1
  defp break_number(x) do
    [1, x - 10]
  end

  # header function to set acc
  defp sum_numbers(_numbers, acc \\ 0)

  # if the list is empty return acc
  defp sum_numbers([], acc) do
    acc
  end

  # add first item to acc
  defp sum_numbers([x | rest], acc) do
    sum_numbers(rest, acc + x)
  end

  # get last digit by subtracting modulo 10 of result from 10
  defp calulate_last_digit(result) do
    10 - Integer.mod(result, 10)
  end

  # intial call to append [0,0,0] to the bit list
  def compute(bits) do
    compute_logic(append(bits, [0, 0, 0]))
  end

  # we know when we end up with 3 items in the list that is the result
  defp compute_logic(bits = [_x, _y, _z]) do
    bits
  end

  # we remove the leading 0 from the bits
  defp compute_logic([0 | rest]) do
    compute_logic(rest)
  end

  # we apply xor with generator
  defp compute_logic(bits) do
    generator = [1, 0, 1, 1]

    bits
    |> xor(generator)
  end

  # xor on the first 4 items of the list
  defp xor([b1, b2, b3, b4 | rest], [g1, g2, g3, g4]) do
    b1 = num_check(b1, g1)
    b2 = num_check(b2, g2)
    b3 = num_check(b3, g3)
    b4 = num_check(b4, g4)

    compute_logic(append([b1, b2, b3, b4], rest))
  end

  # xor logic
  defp num_check(x, y) do
    if x == y do
      0
    else
      1
    end
  end

  # list appending
  def append([], list) do
    list
  end

  def append(list, []) do
    list
  end

  def append([h | t], list) do
    [h | append(t, list)]
  end

  # above exam stuff

  #   1) Implement a function, toggle/1, that takes a list and returns a list where
  # the elements have changed place two-by-two. If the number of elements is
  # odd the last element keeps its position.
  # Example: toggle([:a,:b,:c,:d,:e,:f,:g]) should give the answer [:b,:a,:d,:c,:f,:e,:g].
  #
  def toggle([x, y | tail]), do: [y, x] ++ toggle(tail)
  def toggle(rest), do: rest

  # 2) Implement a stack: propose a data structure and implement the two functions
  # push/2 and pop/1. The function push/2 should return the updated stack and
  # the function pop/1 should return either: {:ok, any(), stack()} if there is
  # an element on the stack or :no if the stack is empty.
  #
  def push(item, stack \\ []), do: [item | stack]
  def pop([item | stack]), do: {:ok, item, stack}
  def pop([]), do: :no

  # 3) Implement a function flatten/1 that takes a list of lists, that in turn can
  # be lists of lists etc, and returns a at list with all the elements of the original
  # list in the same order. You can use ++ to append two lists.
  # Example, the call: flatten([1,[2],[[3,[4,5]], 6]]) returns: [1,2,3,4,5,6]
  #
  def flatten([head | tail]), do: flatten(head) ++ flatten(tail)
  def flatten([]), do: []
  def flatten(element), do: [element]

  # 4) An h-index can be used to describe how much and how far one runs. Your
  # h-index is the highest value h such that you have run at least h km at least
  # h times. Your h-index is for example 12 if you have done 12 km or more 16
  # times but have not done 13 km or more 13 times. It is fairly simple to have
  # a h-index of 10 but a bit tougher to come up to 30.
  # Implement a function index/1 that, given a list of values that describes runs
  # in km, calculates the h-index. The list is ordered with the longest runs rst.
  # You will be able to calculate the value by going through the list only once.
  # The algorithm is simple:
  # • The initial estimate of the h-index is 0.
  # • Traverse the list and if the rst element is greater than the current
  # estimate,
  #  then increment the estaimate by 1 and continue otherwise,
  #  you have found the correct h-index.
  # Example: index([12,10,8,8,6,4,4,4,2])
  # should return: 5
  def index(_, acc \\ 0)
  def index([head | tail], acc) when head > acc, do: index(tail, acc + 1)
  def index([head | tail], acc) when head <= acc, do: index(tail, acc)
  def index([], acc), do: acc

  # 5) Implement a function compact/1 that takes a tree on the form below and
  # returns a tree where each node with the same key is both its leafs (or if there
  # is only one leaf) had been replaced with a single leaf. The function should
  # be applied recursivly so that changes propagate towords the root.
  # Trees are represented as follows, note that only the leaves have values:
  # @type tree() :: :nil | {:node, tree(), tree()} | {:leaf, any()}
  # Example:
  # compact({:node, {:leaf, 4}, {:leaf, 4}})
  # should return: {:leaf, 4}
  # compact({:node, {:leaf, 5}, {:node, :nil, {:leaf, 4}}})
  # should return: {:node, {:leaf, 5}, {:leaf, 4}}
  def compact(nil) do
    nil
  end

  def compact({:leaf, value}) do
    {:leaf, value}
  end

  def compact({:node, left, right}) do
    cl = compact(left)
    cr = compact(right)
    combine(cl, cr)
  end

  def combine(nil, {:leaf, value}) do
    {:leaf, value}
  end

  def combine({:leaf, value}, nil) do
    {:leaf, value}
  end

  def combine({:leaf, value}, {:leaf, value}) do
    {:leaf, value}
  end

  def combine(left, right) do
    {:node, left, right}
  end

  # q11)
  # Implement a function, drop/2, that takes a list and a number n > 0 and
  # returns a list where every n'th element has been removed.
  # Example: drop([:a,:b,:c,:d,:e,:f,:g,:h,:i,:j], 3) should give the answer [:a,:b,:d,:e,:g,:h,:j].
  def drop(list, n) do
    drop(list, n, n)
  end

  def drop([], _, _) do
    []
  end

  def drop([_ | rest], 1, n) do
    drop(rest, n, n)
  end

  def drop([elem | rest], i, n) do
    [elem | drop(rest, i - 1, n)]
  end

  # q12
  # Implement a function rotate/2 that takes a list, of length l, and a number
  # n, where 0 ≤ n ≤ l, and returns a list where the elements have been rotated
  # n steps.
  # You can use two library functions append/2 and reverse/1 (not ++). Your
  # solution can only call these functions ones each during an evaluation.
  # Example: rotate([:a,:b,:c,:d,:e], 2) returns [:c,:d,:e,:a,:b].

  def rotate(list, 0), do: list

  def rotate([head | tail], i) do
    rotate(Enum.concat(tail, [head]), i - 1)
  end

  # q13
  # Implement a function nth/2 that nds the value of the n'th leaf in a binary
  # tree traversed depth rst left to right. The function shall take a number
  # n > 0 and a tree and return either:
  # • {:found, val} if the n'th leaf is found and has the value val or
  # • {:cont, k} if only n − k leafs were found i.e. you would need k more
  # leafs to nd the n'th leaf.
  # You should not transform the tree to a list and then nd the n'th leaf. You
  # should nd the leaf by traversing the tree and stop as soon as you have found
  # the n'th leaf.
  # Trees are represented as follows, note that there is no empty tree and that
  # only the leaves have values:
  # @type tree() :: {:leaf, any()} | {:node, tree(), tree()}
  # Example:
  # nth(3, {:node, {:node, {:leaf, :a}, {:leaf, :b}}, {:leaf, :c}})
  # should return {:found, :c}

  def nth(1, {:leaf, val}) do
    {:found, val}
  end

  def nth(n, {:leaf, _}) do
    {:cont, n - 1}
  end

  def nth(n, {:node, left, right}) do
    case nth(n, left) do
      {:found, val} ->
        {:found, val}

      {:cont, k} ->
        nth(k, right)
    end
  end

  # q14
  # The worlds best calculator is of course the HP35 that uses reversed polish
  # notation. You will not press 2 + 3 = but 2 3 + and imediately receives the
  # result 5. Each time a number was netered it was added to the stack. If you
  # entered a binary operator the two uppermost elements on the stack was
  # replaced by the result of the operation. If you entered 3 4 + 2 - the answer
  # was 5 and 3 4 + 2 1 + - of course gave 4 as the result.
  # Implement a function hp35/1 that takes a sequence of instructions and returns the result. The instructions consist of either numbers of operators and
  # could of course be of arbitrary length. You don not have to handle illegal
  # sequences, we assume all sequences represent valid expressions.
  # @type op() :: :add | :sub
  # @type instr() :: integer() | op()
  # @type seq() :: [instr()]
  # @spec hp35(seq()) :: integer()
  # Example hp35([3, 4, :add, 2, :sub]) should return 5 since (3+ 4)−2 =
  # 5.
  def hp35(seq) do
    hp35(seq, [])
  end

  def hp35([], [res | _]) do
    res
  end

  def hp35([:add | rest], [a, b | stack]) do
    hp35(rest, [a + b | stack])
  end

  def hp35([:sub | rest], [a, b | stack]) do
    hp35(rest, [b - a | stack])
  end

  def hp35([val | rest], stack) do
    hp35(rest, [val | stack])
  end

  # q15
  # Implement a function pascal/1 that takes a number n (> 0) and returns the
  # n'th row in Pascals triangle. Below you see how the triangle is constructed:
  # the rst row is [1] and the fth row is [1, 4, 6, 4, 1]. The function
  # should of course be able to generate any row not just the ones shown.
  # Think recursively.
  #         [1]
  #       [1 , 1]
  #      [1, 2, 1]
  #    [1, 3 , 3, 1]
  #   [1, 4, 6, 4, 1]
  #   [1, ... 1]
  # Example: pascal(5) returns [1,4,6,4,1].
  def pascal(1), do: [1]

  def pascal(n) do
    [1 | next(pascal(n - 1))]
  end

  def next([1]) do
    [1]
  end

  def next([a | rest]) do
    [b | _] = rest
    [a + b | next(rest)]
  end

  # q21
  # Implement a function, decode/1, that takes a coded sequence and returns
  # the decoded sequence. A coded sequence is represented by a list of tuples
  # {char, n} where char is an element in the decoded sequence and n the
  # number of consecutive occurrences.
  # Example: decode([{:a, 2}, {:c, 1}, {:b, 3}, {:a, 1}]) should give
  # the answer [:a, :a, :c, :b, :b, :b, :a].
  def decode([]), do: []

  def decode([{elem, 0} | code]) do
    decode(code)
  end

  def decode([{elem, n} | code]) do
    [elem | decode([{elem, n - 1} | code])]
  end

  # q22
  # Implement a function zip/2 that takes two lists, x and y, of the same length
  # and returns a list where the i'th element is a tuple {xi, yi}, of the i'th
  # elements of the two lists.
  # Example: zip([:a,:b,:c], [1,2,3]) returns [{:a,1}, {:b,2}, {:c,3}].

  def zip([], []) do
    []
  end

  def zip([x_head | x_tail], [y_head | y_tail]) do
    [{x_head, y_head} | zip(x_tail, y_tail)]
  end

  # q24
  # Implement a function eval/1 that takes an arithmetic expression and returns
  # its value. Arithmetic expressions are represented as follows (with the natural
  # interpretation):
  # @spec expr() :: integer() |
  # {:add, expr(), expr()} |
  # {:mul, expr(), expr()} |
  # {:neg, expr()}
  # Example eval({:add, {:mul, 2, 3}, {:neg, 2}}) should return 4 since
  # 2 ∗ 3 + −2 = 4.

  def eval({:add, x, y}) do
    eval(x) + eval(y)
  end

  def eval({:mul, x, y}) do
    eval(x) * eval(y)
  end

  def eval({:neg, x}) do
    -eval(x)
  end

  def eval(x) do
    x
  end

  # q25
  # Implement a function gray/1 that takes one argument n, a number greater
  # than zero, and generates a list of so called Gray codes for the bit sequences
  # of length n.
  # Example: gray(3) should return:
  # [[0, 0, 0],
  # [0, 0, 1],
  # [0, 1, 1],
  # [0, 1, 0],
  # [1, 1, 0],
  # [1, 1, 1],
  # [1, 0, 1],
  # [1, 0, 0]]
  # A list of Gray codes have the property that two sequences after each other
  # dier in exactly one position. The regular way of encoding binary numbers
  # does not fulll the requirement since two numbers after each other can dier
  # in many positions (binary 3 and 4 is 011 and 100). This sounds complicated but there is a simple solution - we do it recursively.
  # The list of Gray codes for sequences of length zero is the list that only
  # contains the empty sequence [[]].
  # To generate a list with Gray codes of length n then:
  # • generate the list of Gray codes of length n-1
  # • reverse the list to obtain a reversed copy
  # • update the original to a list where we have added 0 to the beginning
  # of all codes
  # • update the copy to a list where we have added 1 to the beginning of
  # all codes
  # • create the resulting list by appending the two lists
  # You can use the builtin function reverse/1 to reverse a list and append/2
  # to append two lists.
  # You might want to implement a function update/2 that takes a list of codes
  # and a value (0 or 1) and returns a list of the updated codes.

  def gray(0) do
    [[]]
  end

  def gray(n) do
    g1 = gray(n - 1)
    r1 = Enum.reverse(g1)
    Enum.concat(update(g1, 0), update(r1, 1))
  end

  def update([], _) do
    []
  end

  def update([h | t], b) do
    [[b | h] | update(t, b)]
  end
end
