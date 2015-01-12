module ApplicationHelper

  def copyrights
    from = 2014
    year = Time.now.year
    res = "&copy; ИВЦ МГИУ, "
    res += year > from ? "#{from}&ndash;#{year}" : from.to_s
    raw "#{res}."
  end

  def awesom(klass, hash = {})
    content_tag(:i, "", class: klass, data: hash[:data],
                          title: hash[:title]).html_safe + hash[:text] 
  end

  def show_link
    res = ''
    if @tutor
      res += link_to 'Stud-online', root_path, class: 'brand'
      res += "\n"
    end
    if @slide > 0
      res += link_to awesom('fa fa-arrow-left'), @presentation.prev_url(@slide)
      if @tutor && !@presentation.private? && !@presentation.auto_open
        res += link_to awesom('fa fa-minus-circle'), presentation_path(@presentation, value: @slide - 1, type: 'hide', format: :json), remote: true
      end
    end
    
    res += "\n&nbsp;\n"
    if @tutor && !@presentation.private? && !@presentation.auto_open
      res += link_to awesom('fa fa-plus-circle'), presentation_path(@presentation, value: @slide, type: 'show', format: :json), remote: true
    end
    if @slide < @presentation.document.sections.count-1
      res += link_to awesom('fa fa-arrow-right'), @presentation.next_url(@slide), class: @no_next && !@tutor ? 'stud-next-slide' : 'none', data: {presentation_id: @presentation.id, slide: @slide+1}
    end
    res.html_safe
  end

end
