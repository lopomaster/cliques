
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
  # https://www.youtube.com/watch?v=132XR-RLNoY


  # Bron-Kerbosch Algorithm with Pivoting
  # @param graph
  # is the graph
  # @param set
  # is the set with the nodes of a maximal clique
  # @param points
  # is the set of nodes to analyse
  # @param exclude
  # is the set of the excluded nodes

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

