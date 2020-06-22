defmodule Bank.Helper.TableFormat do
  @moduledoc false

  alias __MODULE__

  defstruct [:content, :headers, :column_widths, :separator]

  def new(separator), do: %TableFormat{separator: separator}

  def with_content(table, content) do
    %{table | content: content}
  end

  def with_headers(table, headers) do
    %{table | headers: headers}
  end

  def column_widths(table, widths) do
    %{table | column_widths: widths}
  end

  def print(table) do
    [table.headers | table.content]
    |> Enum.map(&(format_row(&1, table)))
    |> Enum.join("\n")
  end

  defp format_row(row, %TableFormat{column_widths: column_widths, separator: separator}) do
    row
    |> Enum.zip(column_widths)
    |> Enum.map(fn {value, width} -> value |> String.pad_trailing(width, " ") end)
    |> Enum.join(separator)
  end
end
