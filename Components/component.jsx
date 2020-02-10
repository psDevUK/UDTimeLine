import React from 'react';
import ReactDOM from "react-dom";
import Chart from "react-google-charts";

const columns = [
  { type: "string", id: "RowLabel" },
  { type: "string", id: "BarLabel" },
  { type: "string", role: "Tooltip" },
  { type: "date", id: "Start" },
  { type: "date", id: "End" }
];

class <%=$PLASTER_PARAM_ControlName%> extends React.Component {

  render() {
    const options = {
      backgroundColor: this.props.backgroundColor,
      colors: this.props.colors,
      timeline: {
        showRowLabels: this.props.showRowLabels,
        showRowNumber: this.props.showRowNumber,
        groupByRowLabel: this.props.groupByRowLabel,
        colorByRowLabel: this.props.colorByRowLabel,
        rowLabelStyle: {
          fontName: this.props.fontName,
          fontSize: this.props.fontSize,
          color: this.props.fontColor,
        },
        barLabelStyle: { fontName: this.props.fontName, fontSize: 14 },
      }
    }
    return (
      <div className="App">
        <Chart
          chartType="Timeline"
          data={[columns, ...this.props.data]}
          width={this.props.width}
          height={this.props.height}
          options={options}
          chartEvents={[
            {
              eventName: "ready",
              callback: ({ chartWrapper, google }) => {
                const chart = chartWrapper.getChart();
          
                google.visualization.events.addListener(chart, "select", e => {
                  const chart = chartWrapper.getChart();
                  const selection = chart.getSelection();
          
                  //only fire if onClick is defined and an selected item can be found
                  if (this.props.onClick && selection && selection.length === 1) {
                    const item = this.props.data[selection[0].row];
                    console.info("SELECT: ", item);
          
                    UniversalDashboard.publish("element-event", {
                      type: "clientEvent",
                      eventId: this.props.onClick,
                      eventName: "onClick",
                      eventData: item
                    });
                  }
                });
              }
            }
          ]}
        />
      </div>
    )
  }
}

export default <%=$PLASTER_PARAM_ControlName %>