<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="chart-container" style="height: 350px; width: 100%;">
  <div class="chart-header">
    <h2 class="chart-title">Báo cáo doanh thu</h2>
    <a href="adminRevenueReport.jsp" class="more-link">More →</a>
  </div>
  <canvas id="revenueChart" style="width: 100%; height: 100%;"></canvas>
</div>


<style>
  .chart-container {
    padding: 20px;
    margin-bottom: 30px;
    background: #fff;
    border-radius: 12px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    box-sizing: border-box;
  }

  .chart-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 20px;
    flex-wrap: nowrap;
  }

  .chart-title {
    margin: 0;
    font-size: 22px;
    font-weight: bold;
  }

  .more-link {
    color: gray;
    font-weight: bold;
    text-decoration: none;
    white-space: nowrap;
  }

  .more-link:hover {
    color: #7265ff;
  }

  canvas {
    height: auto !important;
  }
</style>

<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script>
  const ctx = document.getElementById('revenueChart').getContext('2d');
  const revenueChart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul',
        'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
      datasets: [{
        label: '2024',
        data: [17000, 15000, 16000, 11000, 45000, 60000, 60000,
          79000, 79000, 50000, 66000, 48000],
        backgroundColor: 'rgba(114, 101, 255, 0.5)',
        borderRadius: 6,
        barPercentage: 0.6
      }]
    },
    options: {
      responsive: true,
      maintainAspectRatio: false,
      plugins: {
        legend: {
          display: true,
          labels: {
            color: '#444',
            font: {
              weight: 'bold'
            }
          }
        },
        title: {
          display: false
        }
      },
      scales: {
        y: {
          beginAtZero: true,
          ticks: {
            stepSize: 16000
          }
        }
      }
    }
  });
</script>
