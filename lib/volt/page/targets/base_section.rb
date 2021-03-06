require 'volt/page/targets/dom_template'

module Volt
  # Class to describe the interface for sections
  class BaseSection
    @@template_cache = {}

    def remove
      fail 'not implemented'
    end

    def remove_anchors
      fail 'not implemented'
    end

    def insert_anchor_before_end
      fail 'not implemented'
    end

    def set_template
      fail 'not implemented'
    end

    def set_content_to_template(page, template_name)
      if self.is_a?(DomSection)
        # DomTemplates are an optimization when working with the DOM (as opposed to other targets)
        dom_template = (@@template_cache[template_name] ||= DomTemplate.new(page, template_name))

        set_template(dom_template)
      else
        template = page.templates[template_name]

        if template
          html     = template['html']
          bindings = template['bindings']
        else
          html     = "<div>-- &lt; missing view or tag at #{template_name.inspect}, make sure it's component is included in dependencies.rb &gt; --</div>"
          bindings = {}
        end

        set_content_and_rezero_bindings(html, bindings)
      end
    end
  end
end
