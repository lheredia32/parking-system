# frozen_string_literal: true

class PdfGeneratorService
  def initialize(vehicles)
    @vehicles = vehicles
  end

  def generate
    pdf = Prawn::Document.new(page_size: 'A4', margin: 20)

    pdf.font_size(16) do
      pdf.text "PARKING SYSTEM", align: :center, style: :bold
    end

    pdf.font_size(10) do
      pdf.text "Reporte de Vehículos", align: :center
    end

    pdf.move_down 5
    pdf.font_size(9) do
      pdf.text "Fecha: #{Time.current.strftime('%Y-%m-%d %H:%M:%S')}", align: :center
    end

    pdf.move_down 10

    if @vehicles.any?
      pdf.font_size(10) do
        pdf.text "Total: #{@vehicles.count} vehículo(s)", style: :bold
      end

      pdf.move_down 5

      table_data = [['#', 'Placa', 'Tipo', 'Entrada', 'Salida', 'Tiempo', 'Costo']]

      @vehicles.each_with_index do |vehicle, index|
        table_data << [
          index + 1,
          vehicle.plate_number.upcase,
          vehicle.vehicle_type.to_s,
          vehicle.entry_time.strftime('%Y-%m-%d %H:%M'),
          vehicle.exit_time ? vehicle.exit_time.strftime('%Y-%m-%d %H:%M') : 'En curso',
          vehicle.total_time || '---',
          "$#{vehicle.total_cost}"
        ]
      end

      pdf.table(table_data, position: :center, width: 550) do
        row(0).background_color = '22D3EE'
        row(0).text_color = '000000'
        row(0).font_style = :bold
        row(0).size = 9
        rows(1..-1).size = 8
        rows(1..-1).text_color = '333333'
      end

      pdf.move_down 10

      total_cobrado = @vehicles.sum(&:total_cost)
      pdf.font_size(11) do
        pdf.text "TOTAL COBRADO: $#{total_cobrado}", style: :bold, color: '22C55E'
      end
    else
      pdf.font_size(11) do
        pdf.text "No se encontraron vehículos.", align: :center
      end
    end

    pdf.move_down 20
    pdf.font_size(7) do
      pdf.text "Parking System - Generated: #{Time.current}", align: :center, color: '888888'
    end

    pdf.render
  end
end