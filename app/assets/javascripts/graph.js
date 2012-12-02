/**
 * Created with JetBrains WebStorm.
 * User: андрушка
 * Date: 01.12.12
 * Time: 16:27
 * To change this template use File | Settings | File Templates.
 */


window.onload = function ()
{
    var _data = [23000,20000,15000,25000,30000,27000,18000];
    var _podpis = ['декабрь','2012 январь','февраль','март','апрель','май','июнь'];

    var line = new RGraph.Line('cvs', _data);
    line.Set('chart.curvy', true);

    line.Set('chart.curvy.tickmarks', true);
    line.Set('chart.curvy.tickmarks.fill', null);
    line.Set('chart.curvy.tickmarks.stroke', '#aaa');
    line.Set('chart.curvy.tickmarks.stroke.linewidth', 2);
    line.Set('chart.curvy.tickmarks.size', 5);
    line.Set('chart.tickmarks', 'circle');

    line.Set('chart.tooltips', ['23 000 грн','20 000 грн','15 000 грн','25 000 грн','30 000 грн','27 000 грн','18 000 грн']);

    line.Set('chart.labels', _podpis);
//    line.properties.background.color = '#333'
    line.Draw();
}


