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

  handleClick = () => {
    UniversalDashboard.publish("element-event", {
      type: "clientEvent",
      eventId: this.props.onClick,
      eventName: "onClick",
      eventData: this.getSelection()
    });
  };

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
          select={this.handleClick.bind(this)}
        />
      </div>
    )
  }
}

export default <%=$PLASTER_PARAM_ControlName %>