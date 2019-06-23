
class MaximalCliques

  def initialize graph
    @graph = graph
  end

  def max_cliques
    @cliques ||= []
    bron_kerbosch(@graph, [],@graph.vertices,[]) if @cliques.empty?
    @cliques
  end

  private

  def bron_kerbosch(graph, set, points, exclude)
    @cliques << set if set.size > 2 and exclude.empty? and points.empty?

    points.each_with_index do |vertex, i|
      points[i] = nil
      neighbours = graph.adjacent_vertices(vertex)
      bron_kerbosch(graph,set + [vertex],
                    points & neighbours,
                    exclude & neighbours)
      exclude << vertex
    end
  end

end


