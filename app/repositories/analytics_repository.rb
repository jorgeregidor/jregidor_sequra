class AnalyticsRepository
  def initialize; end

  def read
    ActiveRecord::Base.connection.execute(query)
  end

  private

  def query
    <<~BIGSTRING
      WITH money_year AS (
        SELECT#{' '}
            EXTRACT(YEAR FROM disbursement_date) AS year,
          COUNT(*) AS number_of_disbursements,
          SUM(merchant_amount_cents) AS total_amount_merchants_cents,
            SUM(commision_amount_cents) AS total_commision_amount_cents
        FROM#{' '}
            disbursements#{' '}
        GROUP BY#{' '}
            EXTRACT(YEAR FROM disbursement_date)
      ), minimum_year AS (
        SELECT#{' '}
            EXTRACT(YEAR FROM tmf.date) AS year,
          COUNT(*) as number_minimum_fees,
          SUM(minimum_monthly_fee_cents) as total_minimum_fees_cents
        FROM#{' '}
            total_monthly_fees as tmf
        LEFT JOIN merchants as mer
            ON tmf.merchant_reference = mer.reference
        WHERE tmf.reached = 'false'
        GROUP BY#{' '}
            EXTRACT(YEAR FROM tmf.date)
      )

      SELECT#{' '}
        mon.year,
        mon.number_of_disbursements,
        mon.total_amount_merchants_cents,
        mon.total_commision_amount_cents,
        mnm.number_minimum_fees,
        mnm.total_minimum_fees_cents
      FROM money_year AS mon
      LEFT JOIN minimum_year as mnm
        ON mon.year = mnm.year

    BIGSTRING
  end
end
