import QtQuick 2.3

Item {
    height: 100
    width: 100

    Canvas {
        id: canvas

        anchors.centerIn: parent

        height: parent.height / 2
        width: parent.width

        antialiasing: true

        onPaint: {
            var ctx = canvas.getContext('2d')

            ctx.strokeStyle = "#808080"
            ctx.lineWidth = canvas.height * 0.05
            ctx.beginPath()
            ctx.moveTo(canvas.width * 0.05, canvas.height)
            ctx.lineTo(canvas.width / 2, canvas.height * 0.1)
            ctx.lineTo(canvas.width * 0.95, canvas.height)
            ctx.stroke()
        }
    }
}
