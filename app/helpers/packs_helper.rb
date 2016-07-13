module PacksHelper
    
    def status_icon(kpi,var)
        if var 
            if kpi.vector == "Maximise" && var >= 0
                "<td class='green'> <span class='glyphicon glyphicon-ok'></span> </td>".html_safe
            elsif kpi.vector == "Maximise" && var < 0
                "<td class='red'> <span class='glyphicon glyphicon-remove'></span> </td>".html_safe
            elsif kpi.vector == "Minimise" && var <= 0
                "<td class='green'> <span class='glyphicon glyphicon-ok'></span> </td>".html_safe
            elsif kpi.vector == "Minimise" && var > 0
                "<td class='red'> <span class='glyphicon glyphicon-remove'></span> </td>".html_safe
            end   
        else
            nil
        end
    end

    def units_convert(string)
        string == "Number" ? "#" : "%"
    end

end