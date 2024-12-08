plugins {
	java
	id("org.springframework.boot") version "3.4.0"
	id("io.spring.dependency-management") version "1.1.6"
}

group = "org.FinFlowProject"
version = "0.0.1-SNAPSHOT"

java {
	toolchain {
		languageVersion = JavaLanguageVersion.of(21)
	}
}

repositories {
	mavenCentral()
}

dependencies {
	implementation("org.springframework.boot:spring-boot-starter-web")
	testImplementation("org.springframework.boot:spring-boot-starter-test")
	testRuntimeOnly("org.junit.platform:junit-platform-launcher")

	compileOnly("org.projectlombok:lombok")
	annotationProcessor ("org.projectlombok:lombok")
	implementation("org.springframework.boot:spring-boot-starter-security")
	implementation ("org.springframework.boot:spring-boot-starter-data-jpa")
	runtimeOnly ("org.postgresql:postgresql")
	implementation("io.jsonwebtoken:jjwt:0.12.6")


}

tasks.withType<Test> {
	useJUnitPlatform()
}