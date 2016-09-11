require "securerandom"

colors = %w(default primary info success warning danger)
labels = %w(帰宅 在席 作業 休憩 昼休み 休暇)
6.times do |id|
  State.seed do |s|
    s.id = id
    s.label = labels[id]
    s.color = "btn-" + colors[id]
  end
end

xs = "東西南北上下内外前後".split("")
ys = "山川海谷島森林沼野田畑城".split("")

Member.delete_all

96.times do |id|
  col = id / 8
  row = id % 8
  Member.seed do |s|
    s.id = id
    s.uid = "uuid-" + SecureRandom.uuid
    s.name = xs.sample + ys.sample
    s.col = col
    s.row = row
    s.state_id = rand(6)
  end
end
