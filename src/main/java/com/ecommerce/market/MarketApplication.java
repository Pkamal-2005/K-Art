package com.ecommerce.market;

import javax.sql.DataSource;
import lombok.extern.java.Log;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.jdbc.core.JdbcTemplate;


@SpringBootApplication
@Log
public class MarketApplication implements CommandLineRunner {

	private final DataSource dataSource;

	public MarketApplication(final DataSource dataSource) {this.dataSource = dataSource;}

	public static void main(String[] args) {
		SpringApplication.run(MarketApplication.class, args);
	}

	@Override
	public void run(final String... args) {
		log.info("Datasource: " + dataSource.toString());
		final JdbcTemplate resTemplate = new JdbcTemplate(dataSource);
		resTemplate.execute("select 1");
	}
}
