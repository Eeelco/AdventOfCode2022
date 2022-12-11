defmodule Tree do
  @type tree ::
  {:file, String.t(), integer}
  | {:dir, String.t(), list(tree)}

  @spec build_tree(tree, list(String.t())) :: tree
  def build_tree(tree, []) do
    [tree, []]
  end
  def build_tree({type, name, children}, [hd | tail]) do
    [op | vals] = String.split(hd)
    case op do
      "$"   -> case Enum.at(vals, 0) do
        "ls" -> build_tree({type, name, children}, tail)
        "cd" ->
          dir_name = Enum.at(vals, 1)
          case dir_name do
            ".." -> [{type, name, children}, tail]
            _ ->
              child_tree = Enum.find(children, fn({_,n,_}) -> n == dir_name end)
              [modified_child, rest] = build_tree(child_tree, tail)
              new_children = Enum.map(children, fn({t, n, c}) -> if n == dir_name, do: modified_child, else: {t,n,c} end)
              build_tree({type, name, new_children}, rest)
          end
      end
      "dir" -> build_tree({type, name, [{:dir, Enum.at(vals, 0), []} | children]}, tail)
      _     -> build_tree({type, name, [{:file, Enum.at(vals, 0), String.to_integer(op)} | children]}, tail)
    end
  end


  def mapsize({:file, _, size}) do
    {:file, size, []}
  end

  def mapsize({:dir, _, children}) do
    sizes = Enum.map(children, &mapsize/1)
    {:dir, Enum.map(sizes, fn({_,s,_}) -> s end) |> Enum.sum, sizes}
  end


end
