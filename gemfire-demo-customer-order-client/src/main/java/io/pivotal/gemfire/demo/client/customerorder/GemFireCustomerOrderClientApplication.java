package io.pivotal.gemfire.demo.client.customerorder;

import io.pivotal.gemfire.demo.db.CustomerOrderDBApplication;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.springframework.context.annotation.Import;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@SpringBootApplication
@EnableSwagger2
@Import({ CustomerOrderDBApplication.class })
public class GemFireCustomerOrderClientApplication {

	public static void main(String[] args) {
		SpringApplication.run(GemFireCustomerOrderClientApplication.class, args);
	}
}
